# Optionally override some pagy default with your own in the pagy initializer
require 'pagy/extras/bootstrap'
require 'pagy/extras/overflow'
Pagy::DEFAULT[:items] = 5 
Pagy::DEFAULT[:overflow] = :last_page