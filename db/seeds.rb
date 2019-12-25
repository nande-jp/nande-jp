questions = [
  {category: '日常', content: 'なんでバスのドアは勝手に開くのに、車のドアは自分で開けなくてはいけないの?'},
  {category: '科学', content: 'なんで太陽は海に沈むの？'},
  {category: '科学', content: '何で夜はくらいの？'},
  {category: '科学', content: 'なんで月は光ってるの？'},
  {category: '科学', content: 'ママがお風呂から出たあとは、どうしてこんなにお湯が減ってしまうの？'},
  {category: '科学', content: '「何でブラックホールは吸い込むの？」'},
  {category: '科学', content: '「銀河には何があるの？」'},
  {category: '科学', content: '「銀河は何をするお手伝いなの？」'},
  {category: '科学', content: '「宇宙から見たら何でのび太達のお家は見えないの？」'},
  {category: '科学', content: '「お月様はどうやって生きているの？」'},
  {category: '科学', content: '「鳥は何で飛んでいるの？」'},
  {category: '科学', content: '「人間は何で生きていられるの？」'},
  {category: '日常', content: 'なんで寝ないといけないの？'},
  {category: '日常', content: 'どうして働くと会社がお金くれるの？もしかして会社が、ぷくーってお金作ってるの？'},
  {category: '日常', content: '調剤師さんはどうやってお薬作ってるの？'},
  {category: '日常', content: 'ディズニーランドホテルの中になぜ噴水があるの？'},
  {category: '日常', content: '噴水のしくみってどうなってるの？'},
  {category: '科学', content: '水は、海からできてるの？'},
  {category: '科学', content: 'なんで季節ってあるの？'},
  {category: '哲学', content: '大人はいつ大人になったの？'},
  {category: '科学', content: '風はどこから来るの？'},
  {category: '日常', content: 'オバケっているの？'},
  {category: '日常', content: 'ねぇ、水はどうしたら切れるの？'},
  {category: '日常', content: '三角はどうしてとがってるの〜？'},
  {category: '日常', content: 'どうして小人（こびと）はいるの？'},
  {category: '日常', content: 'これは誰が作ったの？（家・飛行機・道路など）'},
  {category: '日常', content: 'どうして、あの電気は丸いの？'},
  {category: '科学', content: 'どうして寒いの？'},
  {category: '科学', content: 'どうして今は冬なの？'},
  {category: '科学', content: 'ぼく・わたしはどうやって生まれたの？'},
  {category: '科学', content: 'パパにはちんちんがあるけど、〇〇ちゃんにはないの！ママと一緒なの'},
  {category: '科学', content: 'タマタマのなかには何が入ってるの？'},
  {category: '科学', content: 'ねぇ。パパ。ヒトはどこまで大きくなるの〜？'},
  {category: '日常', content: 'なぜ結婚指輪をするのか、なぜ結婚指輪は外さないのか'},
  {category: '科学', content: 'シャボン玉はなぜ割れるのか'},
  {category: '科学', content: 'ゴムはなぜ伸びるのか'},
  {category: '数学', content: 'どうして 1 より 7 が大きいの？'},
  {category: '科学', content: '「太陽って何でできてるの」'},
  {category: '科学', content: '「月の形が変わるのはなんで」'},
  {category: '日常', content: '「なんで昼と夜があるの」'},
  {category: '科学', content: '「カイロはなんで熱くなるの」'},
  {category: '化学', content: '「血ってなんで赤いの」'},
  {category: '哲学', content: '人ってどうして生きてるの？'}
]

category_mappings = {
  '日常': 3,
  '科学': 1,
  '化学': 1,
  '哲学': 2,
  '数学': 1
}

if User.count < 1
  User.create(email: 'admin@gmail.com', password: 'password', username: 'admin')
end

questions.each do |question|
  new_question = User.first.questions.create!(content: question[:content], category: category_mappings[question[:category].to_sym])
  puts new_question
end