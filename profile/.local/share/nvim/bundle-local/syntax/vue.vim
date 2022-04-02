if exists("b:current_syntax")
  finish
end

runtime! syntax/html.vim
unlet b:current_syntax

syntax include @JS syntax/javascript.vim
unlet b:current_syntax

syntax include @CSS syntax/css.vim
unlet b:current_syntax

let b:current_syntax = "vue"

set foldmethod=syntax

syntax region vueTemplateBlock start=/^<template[^>]*>$/ end=/^<\/template>$/ transparent fold extend keepend

syntax region vueScriptBlock start=/^<script[^>]*>$/ end=/^<\/script>$/ contains=@JS fold extend keepend

syntax region vueStyleBlock start=/^<style[^>]*>$/ end=/^<\/style>$/ contains=@CSS fold extend keepend
