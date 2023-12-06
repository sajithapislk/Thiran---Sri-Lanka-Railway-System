<script setup>
import { Head, Link } from "@inertiajs/vue3";
import img1 from "@/public/img/landing_page_1.jpg";
import GuestLayout from "@/Layouts/GuestLayout2.vue";

const props = defineProps({
    canLogin: {
        type: Boolean,
    },
    canRegister: {
        type: Boolean,
    },
    laravelVersion: {
        type: String,
        required: true,
    },
    phpVersion: {
        type: String,
        required: true,
    },
    list: {
        type: Array,
    },
});
</script>
<template>
    <GuestLayout :props="props">
        <div class="antialiased bg-gray-200 font-ssans flex">
            <div class="mx-auto m-8 space-y-6">
                <!--  Monthly card start  -->
                <div
                    v-for="row in list"
                    class="pl-1 w-96 h-20 bg-green-400 rounded-lg shadow-md"
                >
                    <div
                        class="flex w-full h-full py-2 px-4 bg-white rounded-lg justify-between"
                    >
                        <div class="my-auto">
                            <p class="font-bold">
                                {{ row.type == "FOUND" ? "FOUND" : "LOST" }}
                            </p>
                            <p class="text-lg">{{ row.description }}</p>
                        </div>
                        <div class="my-auto">
                            <svg
                                width="50"
                                xmlns="http://www.w3.org/2000/svg"
                                xmlns:xlink="http://www.w3.org/1999/xlink"
                                viewBox="0 0 50 50"
                                fill="#5B5B5B"
                            >
                                <path
                                    d="M5 4C3.346 4 2 5.346 2 7L2 13L3 13L47 13L48 13L48 11C48 9.346 46.654 8 45 8L18.044922 8.0058594C17.765922 7.9048594 17.188906 6.9861875 16.878906 6.4921875C16.111906 5.2681875 15.317 4 14 4L5 4 z M 3 15C2.449 15 2 15.448 2 16L2 43C2 44.654 3.346 46 5 46L45 46C46.654 46 48 44.654 48 43L48 16C48 15.448 47.551 15 47 15L3 15 z M 38 20C39.657 20 41 21.343 41 23C41 24.657 39.657 26 38 26C36.343 26 35 24.657 35 23C35 21.343 36.343 20 38 20 z M 20 24.013672C20.274 24.013672 20.546828 24.117719 20.736328 24.324219L28.640625 32.943359L32.292969 29.292969C32.683969 28.901969 33.314078 28.901969 33.705078 29.292969L41.705078 37.292969C42.097078 37.683969 42.098031 38.316031 41.707031 38.707031C41.512031 38.902031 41.256 39 41 39C40.744 39 40.487969 38.902031 40.292969 38.707031L33 31.414062L25.707031 38.707031C25.316031 39.098031 24.683969 39.098031 24.292969 38.707031C23.901969 38.316031 23.901969 37.683969 24.292969 37.292969L27.226562 34.359375L20 26.480469L9.7363281 37.675781C9.5393281 37.890781 9.271 38 9 38C8.759 38 8.5172187 37.912328 8.3242188 37.736328C7.9172187 37.362328 7.8887188 36.731219 8.2617188 36.324219L19.261719 24.324219C19.451219 24.117719 19.726 24.013672 20 24.013672 z"
                                    fill="#5B5B5B"
                                />
                            </svg>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </GuestLayout>
</template>
