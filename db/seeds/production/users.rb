#coding: utf-8
#Userモデルにデータをいれていく。

#利用ユーザーのデータを10個いれる。
user1 = User.find_or_initialize_by_uid("1")
user1.name = "taro"
user1.password = "taro"
user1.save


user2 = User.find_or_initialize_by_uid("2")
user2.name = "jiro"
user2.password = "jiro"
user2.save


user3 = User.find_or_initialize_by_uid("3")
user3.name = "rio"
user3.password = "rio"
user3.save


user4 = User.find_or_initialize_by_uid("4")
user4.name = "akira"
user4.password = "akira"
user4.save


user5 = User.find_or_initialize_by_uid("5")
user5.name = "gaku"
user5.password = "gaku"
user5.save


#エキスパートのデータも5個いれる。
expert1 = User.find_or_initialize_by_uid("6")
expert1.name = "yu"
expert1.password = "yu"
expert1.advice = true
expert1.save


expert2 = User.find_or_initialize_by_uid("7")
expert2.name = "shu"
expert2.password = "shu"
expert2.advice = true
expert2.save


expert3 = User.find_or_initialize_by_uid("8")
expert3.name = "mika"
expert3.password = "mika"
expert3.advice = true
expert3.save


expert4 = User.find_or_initialize_by_uid("9")
expert4.name = "yuka"
expert4.password = "yuka"
expert4.advice = true
expert4.save


expert5 = User.find_or_initialize_by_uid("10")
expert5.name = "ryo"
expert5.password = "ryo"
expert5.advice = true
expert5.save




























