include Benchmark

class Company
  include Mongoid::Document
  include Sunspot::Mongoid
  include Mongoid::FullTextSearch

  field :name, type: String
  field :email, type: String
  field :phone, type: String
  field :address, type: String
  field :city, type: String
  field :country, type: String
  field :description, type: String

  attr_accessible :name, :email, :city, :country, :address, :phone, :description

  searchable do
    text :name, :email, :city, :country
    string :name
    string :city
    string :email
    string :country
  end

  fulltext_search_in :name, :email, :city, :country

  def self.advance_search(q)
    Company.search do
      fulltext q
      facet :city
      order_by(:name, :desc)
    end
  end

  def self.bench
    Benchmark.benchmark(CAPTION, 7, FORMAT) do |x|
      a = []
      100.times do
        q = Faker::Company.name
        i = x.report("Process #{i}") {
          (1..10).map{
            Thread.new do
              Company.fulltext_search(q)
            end
          }.each(&:join)
        }
        a << i
      end
      [a.inject(:+), a.inject(:+)/a.size]
    end

    # puts result
  end

  def self.bench_query
    Benchmark.benchmark(CAPTION, 7, FORMAT, ">total:", ">avg:") do |x|
      a = []
      100.times do |i|
        q = Faker::Company.name
        i = x.report("Process #{i}") {
          Company.search{ fulltext q }
        }
        a << i
      end
      [a.inject(:+), a.inject(:+)/a.size]
    end
  end

  def self.bench_query_fulltext
    Benchmark.benchmark(CAPTION, 7, FORMAT, ">total:", ">avg:") do |x|
      a = []
      100.times do |i|
        q = Faker::Company.name
        i = x.report("Process #{i}") {
          Company.fulltext_search(q)
        }
        a << i
      end
      [a.inject(:+), a.inject(:+)/a.size]
    end
  end
end
