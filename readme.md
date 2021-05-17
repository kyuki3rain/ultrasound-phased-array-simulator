# 解説

test.mが位相調整可能な方。

test2.mが位相調整できない方です。

# パラメータの説明

alphaが減衰係数（単位をmmに会うよう変換）

width, heightがそれぞれフィールドの大きさです（1mm単位）

focus_x, focus_yが焦点の位置（mm）

Nがトランスデューサの数（これをwidthと違う値にしても、幅が変わるだけで全体の範囲はwidthと同じ値で一定になります）

fが周波数。sが音速（mm）

# 処理

減衰の計算は、とりあえず
```
(1 - 減衰係数x距離)x波
```
で求めたけど計算があってるかわからないです。