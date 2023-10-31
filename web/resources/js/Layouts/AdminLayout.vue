<template>
    <div>
        <sidebar-component></sidebar-component>
        <div class="relative md:ml-64 bg-blueGray-100">
            <navbar-component></navbar-component>
            <slot name="header" />

            <div class="px-4 md:px-10 mx-auto w-full -m-24">
                <slot />

                <footer class="block py-4">
                    <div class="container mx-auto px-4">
                        <hr class="mb-4 border-b-1 border-blueGray-200" />
                        <div
                            class="flex flex-wrap items-center md:justify-between justify-center"
                        >
                            <div class="w-full md:w-4/12 px-4">
                                <div
                                    class="text-sm text-blueGray-500 font-semibold py-1"
                                >
                                    Copyright © {{ date }}
                                    <a
                                        href="#"
                                        class="text-blueGray-500 hover:text-blueGray-700 text-sm font-semibold py-1"
                                    >
                                        Vishwa
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </footer>
            </div>
        </div>
    </div>
</template>
<script setup>
import NavbarComponent from "./admin/components/Navbar.vue";
import SidebarComponent from "./admin/components/Sidebar.vue";
// import LineChartComponent from "./components/LineChart.vue";
// import BarChartComponent from "./components/BarChart.vue";
const date = new Date().getFullYear();
</script>
