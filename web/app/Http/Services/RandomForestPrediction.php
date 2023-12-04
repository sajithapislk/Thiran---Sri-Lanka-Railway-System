<?php

namespace App\Http\Services;

use Illuminate\Support\Facades\Log;
use PDO;
use Rubix\ML\Classifiers\RandomForest;
use Rubix\ML\Classifiers\ClassificationTree;
use Rubix\ML\Datasets\Labeled;
use Rubix\ML\Datasets\Unlabeled;

class RandomForestPrediction
{
    public $input, $sample, $targets;

    public function __construct($input){
        $this->input = $input;
        $this->sample = array();
        $this->targets = array();
    }

    public function predictArrivalTime(){
        $this->readFile('train.csv',5);

        $model = new RandomForest(new ClassificationTree(10), 300, 0.1, true);

        $dataset = new Labeled($this->sample, $this->targets);
        $model->train($dataset);

        $inputDataset = new Unlabeled([$this->input]);
        $prediction = $model->predict($inputDataset);
        return $prediction[0];
    }

    public function readFile($filename, $target_col){
        $filePath = storage_path('app/' . $filename);

        $file = fopen($filePath, 'r');
        $row_c = 0;


        while (($row = fgetcsv($file)) !== false) {
            $row_c++;
            if($row_c != 1){
                $tempArray = [];
                for ($col=0; $col < count($row) ; $col++) {
                    if ($col == $target_col) {
                        array_push($this->targets, $row[$col]);
                    } else if ($col != $target_col){
                        array_push($tempArray, $row[$col]);
                    }
                }
                array_push($this->sample, $tempArray);
            }
        }
        fclose($file);
    }

}
