Dir['**/*.rb', base: 'lib'].each do |file|
  require_relative file
end
