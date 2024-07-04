# db/seeds.rb

# ユーザーの作成
user1 = User.first

unless user1
  puts "No User found. Please create a User first."
  return
end

# ユーザー会社の作成
company1 = UserCompany.find_or_create_by!(
  user: user1,
  corporate_number: "1234567890123",
  corporate_name: "株式会社",
)

# 求職アプリケーションの作成
10.times do |i|
  job_app = JobApplication.create!(
    user: user1,
    user_company: company1,
    name: "求人ポジション #{i + 1}",
    annual_income: 5000000 + i * 100000,
    level_of_interest: rand(1..5),
    employment_type: [0, 1].sample # 0: パートタイム, 1: フルタイム
  )

  # 各求職アプリケーションのTODOリストの作成
  JobApplicationTodo.create!(
    user: user1,
    job_application: job_app,
    name: "求人ポジション #{i + 1} のフォローアップ",
    deadline: DateTime.now + (i + 1).days,
    status: 0, # 未開始
    note: "求人ポジション #{i + 1} のフォローアップメール。"
  )

  # 各求職アプリケーションの面接の作成
  interview = Interview.create!(
    user: user1,
    job_application: job_app,
    name: "求人ポジション #{i + 1} の面接",
    interview_time: DateTime.now + (i + 2).days,
    interview_type: ["電話", "ビデオ", "対面"].sample,
    interview_url: "https://example.com/interview/#{i + 1}",
    interview_address: "123 面接通り、東京、日本"
  )

  # 各面接の面接項目の作成
  InterviewItem.create!(
    interview: interview,
    name: "求人ポジション #{i + 1} の面接質問の準備"
  )
end

# コンソールに確認メッセージを出力
puts "シーディングが正常に完了しました！"
