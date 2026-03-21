; extends

; Inject the underlying language (set via gotmpl_lang buffer variable) into
; text nodes so content between template actions gets syntax highlighting.
((text) @injection.content
  (#inject-lang-from-buf!)
  (#set! injection.combined))
