defmodule(Short.ShortURL, do: use(Puid, bits: 64, chars: :safe64))
