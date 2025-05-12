
module tb_acs();

  wire [3:0] new_pm;
  wire decision;
  reg  [1:0] brch_m1;
  reg  [1:0] brch_m2;
  reg  [3:0] path_m1;
  reg  [3:0] path_m2;

  add_compare_select acs_cir(new_pm,decision,path_m1,brch_m1,path_m2,
                             brch_m2);
  
  initial  
  begin
    $display(" << Starting the simulation >>");
    path_m1 = 4'd0;
    brch_m1 = 2'd0;
    path_m2 = 4'd0;
    brch_m2 = 2'd0;
    #1 
      path_m1 = 4'd0;
      brch_m1 = 2'd1;
      path_m2 = 4'd6;
      brch_m2 = 2'd2;

    #1 
      path_m1 = 4'd7;
      brch_m1 = 2'd2;
      path_m2 = 4'd0;
      brch_m2 = 2'd3;

    #1 
      path_m1 = 4'd14;
      brch_m1 = 2'd1;
      path_m2 = 4'd13;
      brch_m2 = 2'd0;

    #1 
      path_m1 = 4'd9;
      brch_m1 = 2'd3;
      path_m2 = 4'd8;
      brch_m2 = 2'd1;

    #1 
      path_m1 = 4'd15;
      brch_m1 = 2'd1;
      path_m2 = 4'd15;
      brch_m2 = 2'd0;

    #1 
      path_m1 = 4'd15;
      brch_m1 = 2'd1;
      path_m2 = 4'd15;
      brch_m2 = 2'd2;

    #1 
      path_m1 = 4'd13;
      brch_m1 = 2'd3;
      path_m2 = 4'd14;
      brch_m2 = 2'd2;

    #1 
      path_m1 = 4'd14;
      brch_m1 = 2'd3;
      path_m2 = 4'd15;
      brch_m2 = 2'd3;

    #1 
      path_m1 = 4'd15;
      brch_m1 = 2'd3;
      path_m2 = 4'd15;
      brch_m2 = 2'd3;

    #1 
      path_m1 = 4'd16;
      brch_m1 = 2'd8;
      path_m2 = 4'd2;
      brch_m2 = 2'd3;

    #1 
      path_m1 = 4'd12;
      brch_m1 = 2'd2;
      path_m2 = 4'd12;
      brch_m2 = 2'd1;

    #1 
      path_m1 = 4'd9;
      brch_m1 = 2'd1;
      path_m2 = 4'd10;
      brch_m2 = 2'd2;

    #20 ;
    $display(" << Finishing the simulation >>");
    $finish;
  end
endmodule

