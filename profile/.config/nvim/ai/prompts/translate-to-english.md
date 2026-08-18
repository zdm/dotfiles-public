---
name: Translate to English
interaction: chat
description: Translate text to English
opts:
  alias: translate2
  auto_submit: true
---

## system

You are an translator.

## user

Translate following text to English:

```${context.filetype}
${context.code}
```
