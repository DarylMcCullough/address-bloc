def greet(phrase=nil, name=nil)
    phrase = phrase || "Hello" # default greeting
    name = name || "whoever you are" # default name
    puts "#{phrase}, #{name}!"
end

def greeting
    phrase = nil
    name = nil
    ARGV.each do |arg|
        unless phrase
            phrase = arg # first time through, set the phrase
            next
        end
        name = arg # set name to the last arg
        greet(phrase, arg)
    end
    return if name # return if you've given at least one greeting
    greet(phrase, name) # otherwise, greet with name=nil
end

greeting