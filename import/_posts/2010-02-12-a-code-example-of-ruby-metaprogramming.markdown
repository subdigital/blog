--- 
layout: post
title: A Code Example of Ruby Metaprogramming
date: 2010-2-12
comments: true
link: false
---
I'll let the code speak for itself:
{% codeblock %}
class Animal
def sound
puts 'A non-descript sound is emitted from the animal'
end
end
class Frog < Animal
def sound
puts 'Ribbit!'
end
end
class Cat < Animal
def sound
puts 'Meow!'
end
end
class Person
attr_accessor :name
def initialize(name)
@injured = false
@name = name
end
def injure!(by = nil)
print "#{name}: Help I'm being attacked"
print " by a #{by.class}" if by
print '!'
puts
@injured = true
end
def injured?
@injured
end
end
module Aggression
def self.apply_to_all_animals
animal_classes = Module.constants.map { |x| Module.const_get(x) }.select { |x| x.respond_to?(:superclass) && x.superclass == Animal }
animal_classes.each do |animal_class|
animal_class.module_eval do
include Aggression
end
end
end
def attack(person)
sound
puts "*Munch*"
person.injure!(self)
sound
puts
end
end
bonsai = Cat.new
brian = Frog.new
people = [Person.new('Ollie'), Person.new('manitoba98')]
begin
bonsai.attack(people[0])
rescue => e
puts 'Aww bonsai isn\'t capable of agressition. How cute'
end
begin
brian.attack(people[0])
rescue => e
puts 'Nor is brian awwww'
end
puts
# and then god said:
Aggression.apply_to_all_animals
bonsai.attack(people[0])
brian.attack(people[1])
{% endcodeblock %}
<p>
Output:
</p>
<pre style='background-color:#333; border-color: #333; color: #ccc; font-weight: thin; font-size: 1.2em; padding: 15px;'>
Aww bonsai isn't capable of agressition. How cute
Nor is brian awwww
Meow!
*Munch*
Ollie: Help I'm being attacked by a Cat!
Meow!
Ribbit!
*Munch*
manitoba98: Help I'm being attacked by a Frog!
Ribbit!
{% endcodeblock %}
Found <a href="">here</a>.
<p>Needless to say, I'm really enjoying Ruby.</p>
