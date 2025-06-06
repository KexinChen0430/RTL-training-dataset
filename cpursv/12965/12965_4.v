
module rcn_bridge(input  rst,
                  input  clk,
                  input  [68:0] main_rcn_in,
                  output [68:0] main_rcn_out,
                  input  [68:0] sub_rcn_in,
                  output [68:0] sub_rcn_out);

  parameter  ID_MASK = 0;
  parameter  ID_BASE = 1;
  parameter  ADDR_MASK = 0;
  parameter  ADDR_BASE = 1;
  reg  [68:0] main_rin;
  reg  [68:0] main_rout;
  reg  [68:0] sub_rin;
  reg  [68:0] sub_rout;

  assign main_rcn_out = main_rout;
  assign sub_rcn_out = sub_rout;
  wire [5:0]  my_id_mask = ID_MASK;

  wire [5:0]  my_id_base = ID_BASE;

  wire [23:0]  my_addr_mask = ADDR_MASK;

  wire [23:0]  my_addr_base = ADDR_BASE;

  wire  main_req = main_rin[68] && main_rin[67];

  wire  main_rsp = main_rin[68] && !main_rin[67];

  wire 
       main_id_match = (my_id_mask & main_rin[65:60]) == my_id_base;

  wire 
       main_addr_match = (my_addr_mask[23:2] & main_rin[55:34]) == my_addr_base[23:2];

  wire  sub_req = sub_rin[67] && sub_rin[68];

  wire  sub_rsp = !sub_rin[67] && sub_rin[68];

  wire 
       sub_id_match = (sub_rin[65:60] & my_id_mask) == my_id_base;

  wire 
       sub_addr_match = (sub_rin[55:34] & my_addr_mask[23:2]) == my_addr_base[23:2];

  wire 
       main_2_main = (main_req && !main_addr_match) || 
(
(
((main_rsp && !main_addr_match) || 
(!main_addr_match && (main_req && !main_id_match)) || (main_req && !main_addr_match)) && !main_id_match) || (!main_id_match && main_rsp));

  wire 
       sub_2_sub = (sub_rsp && (sub_req && sub_addr_match)) || 
((sub_addr_match && sub_id_match && sub_req) || 
(sub_addr_match && (sub_rsp && sub_id_match)) || (sub_rsp && sub_id_match)) || 
(((sub_req && sub_addr_match) || sub_rsp) && 
(sub_req && (sub_id_match || sub_addr_match)));

  wire  no_cross = sub_2_sub || main_2_main;

  wire 
       main_2_sub = 
(
(main_addr_match && (main_req || main_id_match) && main_rsp) || (main_rsp && main_id_match) || 
((main_addr_match && main_req) || 
(main_addr_match && main_rsp))) && (main_req || main_id_match);

  wire 
       sub_2_main = 
(sub_rsp && 
(
(
((sub_req && !sub_addr_match) || 
(!sub_id_match || 
(sub_req && (!sub_addr_match || !sub_id_match) && sub_rsp))) && sub_req) || (!sub_id_match && sub_rsp) || 
(sub_rsp && (sub_req && !sub_addr_match)))) || 
(
(
(
((sub_req && !sub_addr_match) || 
(!sub_id_match || 
(sub_req && (!sub_addr_match || !sub_id_match) && sub_rsp))) && sub_req) || (!sub_id_match && sub_rsp) || 
(sub_rsp && (sub_req && !sub_addr_match))) && !sub_addr_match);

  
  always @(posedge clk or posedge rst)
      if (rst) 
        begin
          main_rin <= 69'd0;
          main_rout <= 69'd0;
          sub_rin <= 69'd0;
          sub_rout <= 69'd0;
        end
      else 
        begin
          main_rin <= main_rcn_in;
          main_rout <= (!no_cross && sub_2_main) ? sub_rin : 
                      (!no_cross && main_2_sub) ? 69'd0 : main_rin;
          sub_rin <= sub_rcn_in;
          sub_rout <= (!no_cross && main_2_sub) ? main_rin : 
                     (!no_cross && sub_2_main) ? 69'd0 : sub_rin;
        end
endmodule

