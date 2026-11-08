<script setup lang="ts">defineProps<{title:string;description:string;icon?:string}>()</script>
<template><div class="empty-state"><UIcon :name="icon||'i-lucide-search'" class="text-3xl text-slate-400"/><h2>{{title}}</h2><p>{{description}}</p><slot/></div></template>
