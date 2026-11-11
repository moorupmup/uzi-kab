<script setup lang="ts">defineProps<{title:string;description?:string}>()</script>
<template><div class="page-heading no-print"><div><h1>{{title}}</h1><p v-if="description">{{description}}</p></div><div class="page-heading-actions"><slot/></div></div></template>
