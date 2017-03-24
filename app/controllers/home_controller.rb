class HomeController < ApplicationController
  before_action :lotto;
  require ('open-uri')
  require ('json')
  
  def index 
  end
  
  def result 
  end
  
  def lotto
    @get_info = JSON.parse open('http://www.nlotto.co.kr/common.do?method=getLottoNumber&drwNo=').read
    
    @drw_numbers = []
    @get_info.each do |k, v|
        @drw_numbers << v if k.include? 'drwtNo'
    end
    @drw_numbers.sort!
    
    @bonus_number = @get_info["bnusNo"]
    @my_numbers = [*1..45].sample(6).sort
    @match_numbers = @drw_numbers & @my_numbers
    @match_cnt = @match_numbers.count    
    
    if @match_cnt == 6 then @result = '1등'
      elsif @match_cnt == 5 && @my_numbers.include?(@bonus_number) then @result = '2등'
      elsif @match_cnt == 5 then @result = '3등'
      elsif @match_cnt == 4 then @result = '4등'
      elsif @match_cnt == 3 then @result =  '5등'
      else @result = '꽝'
    end
  end
end
