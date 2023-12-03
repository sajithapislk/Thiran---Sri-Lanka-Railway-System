<script setup>
import { ref, computed } from "vue";
import AdminLayout from "@/Layouts/AdminLayout.vue";
import InputError from "@/Components/InputError.vue";
import InputLabel from "@/Components/InputLabel.vue";
import { Head, Link, useForm } from "@inertiajs/vue3";
import TextInput from "@/Components/TextInput.vue";
import { CheckIcon, ChevronUpDownIcon } from "@heroicons/vue/20/solid";
import {
    Combobox,
    ComboboxInput,
    ComboboxButton,
    ComboboxOptions,
    ComboboxOption,
    TransitionRoot,
} from "@headlessui/vue";

const props = defineProps({
    list: Array,
});
let distance = ref(0.0);
let tempList = ref([]);
const toggleValue = ref(false);
const name = ref("");

const handleToggleChange = () => {
    const sum = tempList.value.reduce(
        (accumulator, item) =>
            accumulator +
            (toggleValue.value === false ? item.left_direction : item.right_direction),
        0
    );
    distance.value = sum;
    console.log(distance.value);
};
const tempSave = () => {
    tempList.value.push(selected.value);
    handleToggleChange();
};

let selected = ref(props.list[0]);
let query = ref("");

let filteredStation = computed(() =>
    query.value === ""
        ? props.list
        : props.list.filter((station) =>
              station.name
                  .toLowerCase()
                  .replace(/\s+/g, "")
                  .includes(query.value.toLowerCase().replace(/\s+/g, ""))
          )
);

const submit = () => {
    useForm({
        stations: tempList.value,
        name: name.value,
        direction: toggleValue.value === false ? 'LEFT' : 'RIGHT',
    }).post(route("admin.route.store"))
        .then(() => {
            tempList.value = [];
            selected.value = props.list[0];
            distance.value = 0.0;
        })
        .catch((error) => {});
};
</script>

<template>
    <AdminLayout>
        <template #header>
            <div class="relative bg-blue-800 md:pt-32 pb-32 pt-12">
                <div class="px-4 md:px-10 mx-auto w-full">
                    <div></div>
                </div>
            </div>
        </template>

        <div class="w-full xl:w-full mb-12 xl:mb-0 px-4">
            <div
                class="relative flex flex-col min-w-0 break-words bg-white w-2/4 mx-auto mb-6 shadow-lg rounded"
            >
                <div class="rounded-t mb-0 px-4 py-3 border-0">
                    <div class="flex flex-wrap items-center">
                        <div
                            class="relative w-full px-4 max-w-full flex-grow flex-1"
                        >
                            <h3
                                class="font-semibold text-2xl text-blueGray-700"
                            >
                                Route Insert
                            </h3>
                        </div>
                        <div
                            class="relative w-full px-4 max-w-full flex-grow flex-1 text-right"
                        ></div>
                    </div>
                </div>
                <div class="block w-full overflow-x-auto">
                    <div class="mb-0 px-4 py-3">
                        <div class="flex">
                            <div class="flex-1 py-5 pl-5 overflow-hidden">
                                <h1
                                    class="inline text-lg font-semibold leading-none"
                                >
                                    Station
                                </h1>
                            </div>
                        </div>
                        <div class="px-5 pb-5">
                            <div class="flex">
                                <div class="flex-grow w-3/4 mr-2">
                                    <Combobox v-model="selected">
                                        <div class="relative mt-1">
                                            <div
                                                class="relative w-full cursor-default overflow-hidden rounded-lg bg-white text-left shadow-md focus:outline-none focus-visible:ring-2 focus-visible:ring-white/75 focus-visible:ring-offset-2 focus-visible:ring-offset-teal-300 sm:text-sm"
                                            >
                                                <ComboboxInput
                                                    class="w-full border-none py-2 pl-3 pr-10 text-sm leading-5 text-gray-900 focus:ring-0"
                                                    :displayValue="
                                                        (station) =>
                                                            station.name
                                                    "
                                                    @change="
                                                        query =
                                                            $event.target.value
                                                    "
                                                />
                                                <ComboboxButton
                                                    class="absolute inset-y-0 right-0 flex items-center pr-2"
                                                >
                                                    <ChevronUpDownIcon
                                                        class="h-5 w-5 text-gray-400"
                                                        aria-hidden="true"
                                                    />
                                                </ComboboxButton>
                                            </div>
                                            <TransitionRoot
                                                leave="transition ease-in duration-100"
                                                leaveFrom="opacity-100"
                                                leaveTo="opacity-0"
                                                @after-leave="query = ''"
                                            >
                                                <ComboboxOptions
                                                    class="absolute mt-1 max-h-60 w-full overflow-auto rounded-md bg-white py-1 text-base shadow-lg ring-1 ring-black/5 focus:outline-none sm:text-sm"
                                                >
                                                    <div
                                                        v-if="
                                                            filteredStation.length ===
                                                                0 &&
                                                            query !== ''
                                                        "
                                                        class="relative cursor-default select-none py-2 px-4 text-gray-700"
                                                    >
                                                        Nothing found.
                                                    </div>

                                                    <ComboboxOption
                                                        v-for="station in filteredStation"
                                                        as="template"
                                                        :key="station.id"
                                                        :value="station"
                                                        v-slot="{
                                                            selected,
                                                            active,
                                                        }"
                                                    >
                                                        <li
                                                            class="relative cursor-default select-none py-2 pl-10 pr-4"
                                                            :class="{
                                                                'bg-teal-600 text-white':
                                                                    active,
                                                                'text-gray-900':
                                                                    !active,
                                                            }"
                                                        >
                                                            <span
                                                                class="block truncate"
                                                                :class="{
                                                                    'font-medium':
                                                                        selected,
                                                                    'font-normal':
                                                                        !selected,
                                                                }"
                                                            >
                                                                {{
                                                                    station.name
                                                                }}
                                                            </span>
                                                            <span
                                                                v-if="selected"
                                                                class="absolute inset-y-0 left-0 flex items-center pl-3"
                                                                :class="{
                                                                    'text-white':
                                                                        active,
                                                                    'text-teal-600':
                                                                        !active,
                                                                }"
                                                            >
                                                                <CheckIcon
                                                                    class="h-5 w-5"
                                                                    aria-hidden="true"
                                                                />
                                                            </span>
                                                        </li>
                                                    </ComboboxOption>
                                                </ComboboxOptions>
                                            </TransitionRoot>
                                        </div>
                                    </Combobox>
                                </div>
                                <div class="flex-grow w-1/4 mr-2">
                                    <button
                                        type="button"
                                        @click="tempSave"
                                        class="flex items-center px-5 py-2.5 font-medium tracking-wide text-white capitalize bg-black rounded-md hover:bg-gray-800 focus:outline-none focus:bg-gray-900 transition duration-300 transform active:scale-95 ease-in-out"
                                    >
                                        <svg
                                            xmlns="http://www.w3.org/2000/svg"
                                            height="24px"
                                            viewBox="0 0 24 24"
                                            width="24px"
                                            fill="#FFFFFF"
                                        >
                                            <path
                                                d="M0 0h24v24H0V0z"
                                                fill="none"
                                            ></path>
                                            <path
                                                d="M5 5v14h14V7.83L16.17 5H5zm7 13c-1.66 0-3-1.34-3-3s1.34-3 3-3 3 1.34 3 3-1.34 3-3 3zm3-8H6V6h9v4z"
                                                opacity=".3"
                                            ></path>
                                            <path
                                                d="M17 3H5c-1.11 0-2 .9-2 2v14c0 1.1.89 2 2 2h14c1.1 0 2-.9 2-2V7l-4-4zm2 16H5V5h11.17L19 7.83V19zm-7-7c-1.66 0-3 1.34-3 3s1.34 3 3 3 3-1.34 3-3-1.34-3-3-3zM6 6h9v4H6z"
                                            ></path>
                                        </svg>
                                        <span class="pl-2 mx-1">Insert</span>
                                    </button>
                                </div>
                            </div>
                        </div>
                        <hr class="mt-4" />
                        <div class="flex flex-row-reverse p-3">
                            <div class="flex-initial pl-3"></div>
                            <div class="flex-initial"></div>
                        </div>
                    </div>
                </div>
            </div>
            <div
                class="relative flex flex-col min-w-0 break-words bg-white w-full mb-6 shadow-lg rounded"
            >
                <div class="rounded-t mb-0 px-4 py-3 border-0">
                    <div class="flex flex-wrap items-center">
                        <div
                            class="relative w-full px-4 max-w-full flex-grow flex-1"
                        >
                            <h3
                                class="font-semibold text-base text-blueGray-700"
                            >
                                Temp Station List
                            </h3>
                        </div>
                    </div>
                </div>
                <div class="block w-full overflow-x-auto">
                    <!-- Projects table -->
                    <table
                        class="items-center w-full bg-transparent border-collapse"
                    >
                        <thead>
                            <tr>
                                <th
                                    class="px-6 bg-blueGray-50 text-blueGray-500 align-middle border border-solid border-blueGray-100 py-3 text-xs uppercase border-l-0 border-r-0 whitespace-nowrap font-semibold text-left"
                                >
                                    order
                                </th>
                                <th
                                    class="px-6 bg-blueGray-50 text-blueGray-500 align-middle border border-solid border-blueGray-100 py-3 text-xs uppercase border-l-0 border-r-0 whitespace-nowrap font-semibold text-left"
                                >
                                    name
                                </th>
                                <th
                                    class="px-6 bg-blueGray-50 text-blueGray-500 align-middle border border-solid border-blueGray-100 py-3 text-xs uppercase border-l-0 border-r-0 whitespace-nowrap font-semibold text-left"
                                >
                                    tp
                                </th>
                                <th
                                    class="px-6 bg-blueGray-50 text-blueGray-500 align-middle border border-solid border-blueGray-100 py-3 text-xs uppercase border-l-0 border-r-0 whitespace-nowrap font-semibold text-left"
                                >
                                    left_direction
                                </th>
                                <th
                                    class="px-6 bg-blueGray-50 text-blueGray-500 align-middle border border-solid border-blueGray-100 py-3 text-xs uppercase border-l-0 border-r-0 whitespace-nowrap font-semibold text-left"
                                >
                                    right_direction
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="(row, index) in tempList" :key="index">
                                <th
                                    class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4 text-left"
                                >
                                    {{ index + 1 }}
                                </th>
                                <td
                                    class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4"
                                >
                                    {{ row.id }} | {{ row.name }}
                                </td>
                                <td
                                    class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4"
                                >
                                    {{ row.tp }}
                                </td>
                                <td
                                    class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4"
                                >
                                    {{ row.left_direction }}
                                </td>
                                <td
                                    class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4"
                                >
                                    {{ row.right_direction }}
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <hr class="mt-4" />
                <div class="flex flex-row p-3">
                    <div class="w-full px-3">
                        <label
                            class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2"
                            for="name"
                        >
                            Name
                        </label>

                        <input
                            class="appearance-none block w-full bg-gray-200 text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
                            id="name"
                            type="text"
                            v-model="name"
                        />
                    </div>
                    <div class="w-full px-3 pt-5">
                        <div class="initial">
                            <label
                                for="Toggle3"
                                class="inline-flex items-center p-2 rounded-md cursor-pointer dark:text-gray-800"
                                >Direction</label
                            >

                            <label
                                for="Toggle3"
                                class="inline-flex items-center p-2 rounded-md cursor-pointer dark:text-gray-800"
                            >
                                <input
                                    id="Toggle3"
                                    type="checkbox"
                                    class="hidden peer"
                                    v-model="toggleValue"
                                    @change="handleToggleChange"
                                />
                                <span
                                    class="px-4 py-2 rounded-l-md dark:bg-violet-400 peer-checked:dark:bg-gray-300"
                                    >Left</span
                                >
                                <span
                                    class="px-4 py-2 rounded-r-md dark:bg-gray-300 peer-checked:dark:bg-violet-400"
                                    >Right</span
                                >
                            </label>
                        </div>
                    </div>
                    <div class="w-full px-3 pt-5">
                        Total Distance : {{ distance }} KM
                    </div>
                    <div class="flex-initial pl-3 pt-5">
                        <button
                            type="button"
                            @click="submit"
                            class="flex items-center px-5 py-2.5 font-medium tracking-wide text-white capitalize bg-black rounded-md hover:bg-gray-800 focus:outline-none focus:bg-gray-900 transition duration-300 transform active:scale-95 ease-in-out"
                        >
                            <svg
                                xmlns="http://www.w3.org/2000/svg"
                                height="24px"
                                viewBox="0 0 24 24"
                                width="24px"
                                fill="#FFFFFF"
                            >
                                <path d="M0 0h24v24H0V0z" fill="none"></path>
                                <path
                                    d="M5 5v14h14V7.83L16.17 5H5zm7 13c-1.66 0-3-1.34-3-3s1.34-3 3-3 3 1.34 3 3-1.34 3-3 3zm3-8H6V6h9v4z"
                                    opacity=".3"
                                ></path>
                                <path
                                    d="M17 3H5c-1.11 0-2 .9-2 2v14c0 1.1.89 2 2 2h14c1.1 0 2-.9 2-2V7l-4-4zm2 16H5V5h11.17L19 7.83V19zm-7-7c-1.66 0-3 1.34-3 3s1.34 3 3 3 3-1.34 3-3-1.34-3-3-3zM6 6h9v4H6z"
                                ></path>
                            </svg>
                            <span class="pl-2 mx-1">Save</span>
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <div class="w-full xl:w-4/12 px-4"></div>
    </AdminLayout>
</template>
