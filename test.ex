Stream.map(1..10, fn el ->
  el + 1
end)
|> Stream.chunk_every(3)
|> Enum.each(fn chunk ->
  IO.inspect(chunk)
end)
