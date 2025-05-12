
module bug166;

  assign {{o1,o2},o3,o4,{o5,o6}} = {{i1,i2},i3,i4,{i5,i6}};
endmodule

