<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Book;
use App\Models\Payment;
use App\Models\ScheduleTime;
use App\Models\TempReservation;
use Illuminate\Http\Request;
use Srmklive\PayPal\Services\PayPal as PayPalClient;
use Barryvdh\DomPDF\Facade\Pdf;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Inertia\Inertia;

class PaypalController extends Controller
{
    /**
     * create transaction.
     *
     * @return \Illuminate\Http\Response
     */
    public function createTransaction()
    {
        return view('transaction');
    }
    public  function generateRandomString($length = 20)
    {
        $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
        $charactersLength = strlen($characters);
        $randomString = '';
        for ($i = 0; $i < $length; $i++) {
            $randomString .= $characters[rand(0, $charactersLength - 1)];
        }
        return $randomString;
    }
    /**
     * process transaction.
     *
     * @return \Illuminate\Http\Response
     */
    public function processTransaction(Request $request)
    {
        $uniqueCode = $this->generateRandomString();
        $upcomingDeal = ScheduleTime::find($request->id);

        Log::Info($upcomingDeal);

        $price = $request->qty * $upcomingDeal->price;

        Log::Info($price);

        $provider = new PayPalClient;
        $provider->setApiCredentials(config('paypal'));
        $paypalToken = $provider->getAccessToken();

        $payment = Payment::create([
            'method'=>'paypal',
            'status'=>'PENDING',
            'amount'=>$price,
            'token'=>$uniqueCode,
        ]);

        Log::Info($payment);

        $tempReservation = TempReservation::create([
            'st_id'=>$upcomingDeal->id,
            'payment_id'=>$payment->id,
            'from_s_id'=>$request->from_s_id,
            'to_s_id'=>$request->to_s_id,
            'distance'=>$upcomingDeal->id,
            'seat_type'=>$upcomingDeal->id,
            'nop'=>$upcomingDeal->id,
            'price'=>$upcomingDeal->id
        ]);


        Log::Info($tempReservation);

        $response = $provider->createOrder([
            "intent" => "CAPTURE",
            "application_context" => [
                "return_url" => route('successTransaction'),
                "cancel_url" => route('cancelTransaction'),
            ],
            "purchase_units" => [
                0 => [
                    "reference_id" => $uniqueCode,
                    "amount" => [
                        "currency_code" => "USD",
                        "value" => "10"
                    ]
                ]
            ]
        ]);
        // dd($response);
        if (isset($response['id']) && $response['id'] != null) {

            // redirect to approve href
            foreach ($response['links'] as $links) {
                if ($links['rel'] == 'approve') {
                    return redirect()->away($links['href']);
                }
            }

            // return redirect()
            //     ->route('patient.booking.paypal.cancel_transaction')
            //     ->with('error', 'Something went wrong.');


            return Inertia::render('ErrorPage', ['error' => 'Something went wrong.']);
        } else {
            // return redirect()
            //     ->route('patient.booking.paypal.cancel_transaction')
            //     ->with('error', $response['message'] ?? 'Something went wrong.');


            return Inertia::render('ErrorPage', ['error' => 'Something went wrong.']);
        }
    }
    /**
     * success transaction.
     *
     * @return \Illuminate\Http\Response
     */
    public function successTransaction(Request $request)
    {
        $userId = Auth::id();

        $provider = new PayPalClient;
        $provider->setApiCredentials(config('paypal'));
        $paypalToken = $provider->getAccessToken();
        $response = $provider->capturePaymentOrder($request['token']);
        $token = $response['purchase_units'][0]['reference_id'];
        if (isset($response['status']) && $response['status'] == 'COMPLETED') {
            $payment = Payment::where('token',$token)->first();

            $payment->update([
                'status'=>'SUCCESS',
                'response'=>$response
            ]);

            $TempReservation = TempReservation::where('payment_id', $payment->id)->first();

            Book::create([
                'uid'=>$userId,
                'st_id'=>$TempReservation->st_id,
                'payment_id'=>$TempReservation->payment_id,
                'from_s_id'=>$TempReservation->from_s_id,
                'to_s_id'=>$TempReservation->to_s_id,
                'distance'=>$TempReservation->distance,
                'seat_type'=>$TempReservation->seat_type,
                'nop'=>$TempReservation->nop,
                'price'=>$TempReservation->price
            ]);

            return "done";
        } else {
            return "error";
        }
    }
    /**
     * cancel transaction.
     *
     * @return \Illuminate\Http\Response
     */
    public function cancelTransaction(Request $request)
    {
        return redirect()
            ->route('createTransaction')
            ->with('error', $response['message'] ?? 'You have canceled the transaction.');
    }

    function pdf($id) {
        $cruiseDeal = Book::with(['deal','available_room','user','payment'])->find($id);
        // return $cruiseDeal;
        return view('PDF.invoice',compact('cruiseDeal'));
    }
    function pdf_download($id) {
        $cruiseDeal = Book::find($id);
        // return $cruiseDeal;
        // return view('PDF.invoice',compact('cruiseDeal'));
        $pdf = Pdf::loadview('pdf.invoice', [
            'cruiseDeal' => $cruiseDeal
        ]);
        $orientation = 'landscape';
        $customPaper = array(0,0,950,950);
        $pdf->setPaper($customPaper, $orientation);
        return $pdf->stream();

    }
}
