# Markdownplus::Julia

Julia plugin for [Markdownplus](https://github.com/cpetersen/markdownplus)

## Installation

Add this line to your application's Gemfile:

    gem 'markdownplus-julia'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install markdownplus-julia

### Note

This gem requires `julia` be accessable from the `$PATH`.

## Usage

The following will pull the data from `my_data_variable` and put it into a data frame which will be accessible from julia by the name `my_julia_variable`. It then creates a graph using [Gadfly](https://github.com/dcjones/Gadfly.jl) and outputs an SVG directly into the rendered HTML.

```
  ```julia(dataFrame('my_julia_variable',get('my_data_variable'))),strip_whitespace(),raw()
  using Gadfly
  myplot = plot(x=1:10, y=2.^rand(10),
       Scale.y_sqrt, Geom.point, Geom.smooth,
       Guide.xlabel("Stimulus"), Guide.ylabel("Response"), Guide.title("Dog Training"))
  draw(SVGJS(STDOUT, 4inch, 3inch), myplot)
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
