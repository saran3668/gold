#!/usr/bin/env ruby

require 'rubygems'
require 'nokogiri'
require 'open-uri'

class GoldRate

   
  # Define the URL with the argument passed by the user
  uri = "https://www.fresherslive.com/gold-rate-today/bangalore"
   
  # Use Nokogiri to get the document
  doc = Nokogiri::HTML(open(uri))
    
  trim = doc.css('.goldprice_tab')
  
  dates = (trim.css("td[data-label='Date']").text).split(/(?<=[0-9][0-9]-[0-9][0-9]-[0-9][0-9][0-9][0-9])/)
  target_date = open("/home/ubuntu/saran/gold/gold-date.txt", 'w')
  target_date.puts(dates)
  target_date.close()
  read_date = open("/home/ubuntu/saran/gold/gold-date.txt", 'r')

  prices_22_carat = (trim.css("td[data-label='22 Carat Price']").text).tr('₹', '').tr(',', '').strip.gsub!(' ',"\n")
  target_price = open("/home/ubuntu/saran/gold/gold-price.txt", 'w')
  target_price.puts(prices_22_carat)
  target_price.close()
  read_price = open("/home/ubuntu/saran/gold/gold-price.txt", 'r')
  
  
  target = open("/home/ubuntu/saran/gold/gold.txt", 'w')
  read_date.each.zip(read_price.each).each do |date, price|
      if price.to_i < 15000
        target.puts("Price of 22 Carat Gold per gram for #{date.strip} is #{price.strip}")
  else
    target.puts("Price of 22 Carat Gold for 8grams for #{date.strip} is #{price.strip}")
      end
  end
  
  target.close()
  read_date.close()
  read_price.close()

  mail_me = `cat /home/ubuntu/saran/gold/gold.txt | mail -s "Gold Rate Updates" saran.3668@gmail.com`

    
  end   
