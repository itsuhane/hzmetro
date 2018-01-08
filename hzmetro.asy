import unicode;
import flowchart;
settings.outformat="pdf";

unitsize(1cm);
texpreamble("\usepackage{fontspec}\usepackage{xeCJK}\setmainfont{Arial}\setmonofont{Lucida Sans Typewriter}\setCJKmainfont[BoldFont=SimHei]{SimHei}\setCJKmonofont{SimHei}");

real r = 0.2;

struct Station {
  pair coord;
  int  trans;
  int  tshift;
  int orient;
  string name;
  string name_en;
  pair lalign;
  bool display;
  pair c(real s=1) {
    real ss = 2;
    if(orient%2==1) {
      ss = ss*sqrt(2);
    }
    real dx = cos(orient*pi/4);
    real dy = sin(orient*pi/4);
    return coord*r*2+(dx*r*ss*(s-1), dy*r*ss*(s-1));
  }
};

pair point(real x, real y) {
  return (x*r*2, y*r*2);
}

Station station(pair coord, int trans = 1, int orient = 0, string name = '', string name_en = '', int tshift = 0, bool display = true, pair lalign = 10N) {
  Station st = new Station;
  st.coord = coord;
  st.trans = trans;
  st.orient = orient;
  st.name = name;
  st.name_en = name_en;
  st.tshift = tshift;
  st.display = display;
  st.lalign = lalign;
  return st;
}

void draw_station(Station s) {
  if(!s.display) {
    return;
  }
  int n = s.trans;
  int nshift = s.tshift;
  int rot = s.orient;
  real ss = 2;
  if(rot%2==1) {
    ss = ss*sqrt(2);
  }
  pair p1u = (-r*nshift*ss, r);
  pair p1l = (-r*nshift*ss-r, 0);
  pair p1b = (-r*nshift*ss, -r);
  pair p2b = (r*(n-1-nshift)*ss, -r);
  pair p2r = (r*(n-1-nshift)*ss+r, 0);
  pair p2u = (r*(n-1-nshift)*ss, r);
  path spath = p1u{left} .. {down}p1l{down} .. {right}p1b{right} .. {right}p2b{right} .. {up}p2r{up} .. {left}p2u{left} .. {left}cycle;
  pen  spen = rgb(0,0,0)+solid+linewidth(r*10);
  fill(shift(s.coord*r*2)*rotate(rot*45)*spath, rgb(1,1,1));
  draw(shift(s.coord*r*2)*rotate(rot*45)*spath, spen);
  picture labelpic;
  label(labelpic,s.name,(0,18),rgb(0,0,0)+fontsize(20));
  label(labelpic,s.name_en,(0,0),rgb(0,0,0)+fontsize(12));
  draw(labelpic, box((-10,-8),(10,32)), nullpen);
  add(labelpic.fit(), s.c(), s.lalign);
}

void draw_line(Station[] stations, pen p) {
  path line_path = stations[0].c();
  for(int i=1;i<stations.length;++i) {
    line_path = line_path -- stations[i].c();
  }
  draw(line_path, p);
}

void draw_stations(Station[] stations) {
  for (int i=0;i<stations.length;++i) {
    draw_station(stations[i]);
  }
}

pen Rail_Pen = solid+linewidth(r*50);

// 1号线，海棠红
pen Line1_Pen = rgb(0.9098,0.0588,0.3569);
// 2号线，丹桂橙
pen Line2_Pen = rgb(1.0000,0.4667,0.0000);
// 3号线
pen Line3_Pen = rgb(0.9882,0.8549,0.0156);
// 4号线，香樟绿
pen Line4_Pen = rgb(0.0000,0.6784,0.2275);
// 5号线
pen Line5_Pen = rgb(0.3803,0.7568,0.7490);
// 6号线
pen Line6_Pen = rgb(0.2078,0.3059,0.8941);
// 7号线
pen Line7_Pen = rgb(0.4510,0.0078,0.3882);
// 8号线
pen Line8_Pen = rgb(0.9059,0.0863,0.0549);
// 9号线
pen Line9_Pen = rgb(0.8000,0.4118,0.0000);
// 10号线
pen Line10_Pen = rgb(0.7882,0.8078,0.2039);

Station[] Line1_Stations = {
  station((97,-1.5), name = "下沙江滨", name_en="XiaShaJiangBin"),
  station((97,5.5), name = "云水", name_en="YunShui"),
  station((97,12.5), display = false),
  station((95,12.5), name = "文海南路", name_en="South WenHai Rd.", trans = 2, orient = 2),
  station((87,12.5), name = "文泽路", name_en="WenZe Rd."),
  station((80,12.5), name = "高沙路", name_en="GaoSha Rd."),
  station((73,12.5), name = "金沙湖", name_en="JinShaHu"),
  station((66,12.5), name = "下沙西", name_en="West XiaSha", trans = 2, orient = 0),
  station((59,12.5), name = "客运中心", name_en="Coach Center", trans = 2, orient = 2, lalign=20S),
  station((52,12.5), name = "九堡", name_en="JiuBao"),
  station((45,12.5), name = "九和路", name_en="JiuHe Rd."),
  station((38,12.5), name = "七堡", name_en="QiBao"),
  station((31,12.5), name = "彭埠", name_en="PengBu", trans = 2, orient = -2, lalign=20S),
  station((25,12.5), name = "火车东站", name_en="East Railway Sta.", trans = 2, orient = -2),
  station((16,12.5), name = "闸弄口", name_en="ZhaLongKou"),
  station((7.5,12.5), name = "打铁关", name_en="DaTieGuan", trans = 2, orient = 0),
  station((0,12.5), display=false),
  station((0,5.5), name = "西湖文化广场", name_en="West Lake Cultural Sq.", trans = 2, orient = 4, lalign=5N),
  station((0,0), name = "武林广场", name_en="WuLin Sq.", trans = 2, orient = 4, lalign=5N),
  station((0,-7.5), name = "凤起路", name_en="FengQi Rd.", trans = 2, orient = 0, lalign=10SW),
  station((0,-16), name = "龙翔桥", name_en="LongXiangQiao", trans = 2, orient = -2, lalign=10W),
  station((0,-23), display=false),
  station((2.5,-23), name = "定安路", name_en="Ding'An Rd.", lalign=10S),
  station((8.5,-23), name = "城站", name_en="ChengZhan", trans = 2, orient = 2,lalign=20N),
  station((11,-23), display=false),
  station((13.5,-25.5), name = "婺江路", name_en="WuJiang Rd.",lalign=10SW),
  station((16.5,-28.5), name = "近江", name_en="JinJiang", trans = 2, orient = -1,lalign=20S, display=false),
  station((23.5,-35.5), name = "江陵路", name_en="JiangLing Rd.", trans = 2, orient = -1, lalign=10SW),
  station((27,-39), display=false),
  station((27,-46.5), name = "滨河路", name_en="BinHe Rd.", lalign=10W),
  station((27,-52.5), display=false),
  station((28,-53.5), name = "西兴", name_en="XiXing", trans = 2, orient = 4, lalign=20W),
  station((29,-54.5), display=false),
  station((33,-54.5), display=false),
  station((34.5,-56), name = "滨康路", name_en="BinKang Rd.", trans = 2, orient = -2, lalign=10SW),
  station((35,-56.5), display=false),
  station((35,-66.5), name = "湘湖", name_en="XiangHu", lalign=10W),
};

Station[] Line2_Stations = {
  station((-60,50), name = "良渚", name_en="LiangZhu"),
  station((-51.5,50), name = "杜甫村", name_en="DuFu Court"),
  station((-48.5,50), display=false),
  station((-44.5,46), name = "白洋", name_en="BaiYang", lalign=10NE),
  station((-39.5,41), name = "金家渡", name_en="JinJiaDu", trans = 2, orient = -1, lalign=10NE),
  station((-33.5,35), name = "墩祥街", name_en="DunXiang St.", lalign=10NE),
  station((-32,33.5), display=false),
  station((-32,29), name = "三墩", name_en="SanDun", lalign=10W),
  station((-32,23.5), name = "虾龙圩", name_en="XiaLongWei", lalign=10W),
  station((-32,18.5), name = "三坝", name_en="SanBa", trans = 2, orient = 1, lalign=10W),
  station((-32,12.5), name = "文新", name_en="WenXin", lalign=10W),
  station((-32,7), display=false),
  station((-28,7), name = "丰潭路", name_en="FengTan Rd.", lalign=10S),
  station((-22,7), name = "古翠路", name_en="GuCui Rd."),
  station((-15.5,7), name = "学院路", name_en="XueYuan Rd.", trans = 2, orient = 4, lalign=10S),
  station((-9.5,7), name = "下宁桥", name_en="XiaNingQiao"),
  station((-7,7), display=false),
  station((-7,3.5), name = "沈塘桥", name_en="ShenTangQiao", lalign=10SW),
  station((-7,-1.5), display=false),
  station((-4.5,-4), name = "武林门", name_en="WuLinMen", trans = 2, orient = -1, lalign=10W),
  station((-1,-7.5), display=false),
  station((1,-7.5), name = "凤起路", name_en="FengQi Rd.", trans = 2, orient = 4, display = false),
  station((5,-7.5), name = "中河北路", name_en="North ZhongHe Rd.", lalign=10S),
  station((8.5,-7.5), name = "建国北路", name_en="North JianGuo Rd.", trans = 2, orient = 0), // <-- note this one used its transition line
  station((13.5,-7.5), name = "庆菱路", name_en="QingLing Rd.", lalign=10S),
  station((18,-7.5), name = "庆春广场", name_en="QingChun Sq."),
  station((22.5,-7.5), display=false),
  station((25.5,-10.5), name = "钱江路", name_en="QianJiang Rd.", trans = 2, orient = -3, lalign=20SW),
  station((39,-24), name = "钱江世纪城", name_en="QianJiang Centry City", trans = 2, orient = 3, lalign=10NE),
  station((43,-28), name = "盈丰路", name_en="YingFeng Rd.", lalign=10NE),
  station((47.5,-32.5), name = "飞虹路", name_en="FeiHong Rd.", lalign=10NE),
  station((51,-36), display=false),
  station((51,-39.5), name = "振宁路", name_en="ZhenNing Rd.", lalign=10E),
  station((51,-47.5), name = "建设三路", name_en="JianSheSan Rd.", trans = 2, orient = 2, lalign=10W),
  station((51,-50), name = "建设一路", name_en="JianSheYi Rd.", lalign=10E),
  station((51,-58), name = "人民广场", name_en="People Sq.", trans = 2, orient = 2, lalign=10E),
  station((51,-64.5), name = "杭发厂", name_en="HangFaChang", trans = 2, orient = 4, lalign=10E),
  station((51,-71.5), name = "人民路", name_en="RenMin Rd.", trans = 3, orient = -2, lalign=10E),
  station((51,-80.5), name = "潘水", name_en="PanShui", lalign=10E),
  station((51,-85.5), name = "曹家桥", name_en="CaoJiaQiao", lalign=10E),
  station((51,-90), name = "朝阳", name_en="ChaoYang", trans = 2, orient = -2, lalign=10E),
};


Station[] Line3_Stations = {
  station((-1,5.5), name = "西湖文化广场", name_en="West Lake Cultural Sq.", trans = 2, orient = 0, display = false),
  station((-1,0), name = "武林广场", name_en="WuLin Sq.", trans = 2, orient = 0, display = false),
  station((-1,-2.5), display = false),
  station((-3.5,-5), name = "武林门", name_en="WuLinMen", trans = 2, orient = 3, display = false),
};

Station[] Line4_Stations = {
  station((31,11.5), name = "彭埠", name_en="PengBu", trans = 2, orient = 2, display = false),
  station((25,11.5), name = "火车东站", name_en="East Railway Sta.", trans = 2, orient = 2, display = false),
  station((22.5, 11.5), display=false),
  station((22.5,4.5), name = "新风", name_en="XinFeng", lalign=10E),
  station((22.5,0.0), name = "新塘", name_en="XinTang", lalign=10E),
  station((22.5,-5.5), name = "景芳", name_en="JingFang", lalign=10E),
  station((22.5, -9.5), display=false),
  station((24.5,-11.5), name = "钱江路", name_en="QianJiang Rd.", trans = 2, orient = 1, display = false),
  station((30, -17), display=false),
  station((27,-20), name = "江锦路", name_en="JiangJin Rd.", lalign=10SE),
  station((24,-23), name = "市民中心", name_en="Citizen Center", trans=2, orient = -3, lalign=10SE),
  station((20.5,-26.5), name = "城星路", name_en="ChengXing Rd.",lalign=10SE),
  station((17.5,-29.5), name = "近江", name_en="JinJiang", trans = 2, orient = 3, lalign=10S),
  station((12.5,-34.5), name = "甬江路", name_en="YongJiang Rd.", lalign=10NW),
  station((8.5,-38.5), name = "南星桥", name_en="NanXingQiao", trans = 2, orient = -3, lalign=10NW),
  station((3.5,-43.5), name = "复兴路", name_en="FuXing Rd.", lalign=10NW),
  station((-1.5,-48.5), name = "水澄桥", name_en="ShuiChengQiao", lalign=10NW),
  station((-7,-54), name = "联庄", name_en="LianZhuang", lalign=10NW),
  station((-7,-59), name = "中医药大学", name_en="Chinese Medical University", trans=2, orient=4, lalign=10NW),
  station((-7,-64), name = "杨家墩", name_en="YangJiaDun", lalign=10W),
  station((-7,-69), name = "浦沿", name_en="PuYan", trans=2, lalign=10W),
};

Station[] Line5_Stations = {
  station((8.5,12.5), name = "打铁关", name_en="DaTieGuan", trans = 2, orient = 4, display = false),
  station((8.5,0.0), name = "宝善桥", name_en="BaoShanQiao", lalign=10E),
  station((8.5,-7.5), name = "建国北路", name_en="North JianGuo Rd.", trans = 2, orient = 0, display = false),
  station((8.5,-17), trans = 2),
  station((8.5,-23), name = "城站", name_en="ChengZhan", trans = 2, orient = 2, display = false),
};

Station[] Line6_Stations = {
  station((38,-23), name = "钱江世纪城", name_en="QianJiang Centry City", trans = 2, orient = -1, display = false),
  station((30,-31), trans = 2, orient = 3),
  station((24.5,-36.5), name = "江陵路", name_en="JiangLing Rd.", trans = 2, orient = 3, lalign=10SW, display = false),
};

Station[] Line7_Stations = {
  station((13,-22)),
  station((17,-18), trans = 2, orient = 2),
  station((23,-24), name = "市民中心", name_en="Citizen Center", trans=2, orient = 1, display = false),
  station((29,-30), trans=2,orient=-1, display=false),
};

Station[] Line9_Stations = {
  station((60,61.5), name = "临平", name_en="LinPing", trans=2, lalign=10W),
  station((60,53.5), name = "南苑", name_en="NanYuan", lalign=10W),
  station((60,45.5), name = "余杭高铁站", name_en="YuHang Hi-Railway", trans=2, lalign=10W),
  station((60,37.5), name = "翁梅", name_en="WengMei", lalign=10W),
  station((60,29.5), name = "乔司", name_en="QiaoSi", lalign=10W),
  station((60,21.5), name = "乔司南", name_en="South QiaoSi", trans=2, orient=-2, lalign=10W),
  station((60,14.5), display=false),
  station((59,13.5), name = "客运中心", name_en="Coach Center", trans = 2, orient = -2, display = false),
};

draw_line(Line1_Stations, Line1_Pen+Rail_Pen);
draw_line(Line2_Stations, Line2_Pen+Rail_Pen);
//draw_line(Line3_Stations, Line3_Pen+Rail_Pen);
draw_line(Line4_Stations, Line4_Pen+Rail_Pen);
//draw_line(Line5_Stations, Line5_Pen+Rail_Pen);
//draw_line(Line6_Stations, Line6_Pen+Rail_Pen);
//draw_line(Line7_Stations, Line7_Pen+Rail_Pen);
draw_line(Line9_Stations, Line9_Pen+Rail_Pen);
draw_stations(Line1_Stations);
draw_stations(Line2_Stations);
//draw_stations(Line3_Stations);
draw_stations(Line4_Stations);
//draw_stations(Line5_Stations);
//draw_stations(Line6_Stations);
//draw_stations(Line7_Stations);
draw_stations(Line9_Stations);
/*
void draw_legend(string n, pair pos, pen p) {
  path rrect = (-3,-4) -- (3, -4){right} .. {up}(4,-3) -- (4,3){up} .. {left}(3,4) -- (-3, 4){left} .. {down}(-4, 3) -- (-4, -3){down} .. {right}cycle;
  Label num = Label(n);
  fill(shift(pos)*scale(0.25)*rrect, p);
  label(yscale(1.3)*num, shift(pos)*(-0.5,0), rgb(1,1,1)+fontsize(40));
  label("号线", shift(pos)*(0.35,0), rgb(1,1,1)+fontsize(15));
  label("Line "+n, shift(pos)*(0.35,-0.45), rgb(1,1,1)+fontsize(10));
}

draw_legend("1", (-20, -33), Line1_Pen);
draw_legend("2", (-17, -33), Line2_Pen);
//draw_legend("3", (-14, -33), Line3_Pen+opacity(0.2));
draw_legend("4", (-11, -33), Line4_Pen);
//draw_legend("5", (-8, -33), Line5_Pen+opacity(0.2));
//draw_legend("6", (-5, -33), Line6_Pen+opacity(0.2));
//draw_legend("7", (-2, -33), Line7_Pen+opacity(0.2));
//draw_legend("8", (1, -33), Line8_Pen+opacity(0.2));
//draw_legend("9", (4, -33), Line9_Pen+opacity(0.2));
*/
