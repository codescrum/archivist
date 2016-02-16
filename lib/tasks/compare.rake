desc 'Compare question literals'
task :compare_questions => :environment do
  require 'amatch'

  questions = []
  QuestionItem.all.each do |qi|
    questions.push qi.as_json
    questions.last[:prefix] = qi.instrument.prefix
  end
  QuestionGrid.all.each do |qg|
    questions.push qg.as_json
    questions.last[:prefix] = qg.instrument.prefix
  end

  comparisons = []
  (0..questions.count-1).each do |i|
    (i+1..questions.count-1).each do |j|
      comparisons.push({a: i, b: j, r: questions[i]['literal'].jarowinkler_similar(questions[j]['literal'])})
    end
  end

  comparisons.sort_by! { |x| x[:r] }
  comparisons.reverse!

  comparisons.each do |x|
    break if x[:r] < 0.9
    puts "result: %{r}\n\tstr1: %{label1}\n\tstr2: %{label2}" % {
        label1: questions[x[:a]][:prefix].to_s + "." + questions[x[:a]]['label'].to_s,
        label2: questions[x[:b]][:prefix].to_s + "." + questions[x[:b]]['label'].to_s,
        r: x[:r]
    }
  end
end