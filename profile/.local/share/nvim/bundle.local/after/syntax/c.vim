syn clear cBlock

syn region cBlock start="{" end="}" transparent extend

syn match cUserFunction "\<\h\w*\>\_s*([^)]*)\_s*{" transparent contains=cType,cDelimiter,cDefine

syn region cUserFunctionFold start="\<\h\w*\>\_s*([^{]\+{" end="}" transparent fold extend
