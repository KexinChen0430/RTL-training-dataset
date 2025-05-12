
module round_robin_arb  #(parameter  TCQ = 100, WIDTH = 3)
  (grant_ns,grant_r,clk,rst,req,disable_grant,current_master,
                       upd_last_master);

  input  clk;
  input  rst;
  input  [WIDTH+(0-1):0] req;
  wire [WIDTH+(0-1):0] last_master_ns;
  reg  [(1<<<1*WIDTH)-1:0] dbl_last_master_ns;

  
  always @(last_master_ns)
      dbl_last_master_ns = {last_master_ns,last_master_ns};
  reg  [(1<<<1*WIDTH)-1:0] dbl_req;

  
  always @(req)  dbl_req = {req,req};
  reg  [WIDTH+(0-1):0]  inhibit = {WIDTH{1'b0}};

  genvar i;
  genvar j;
  
  generate
      for (i = 0; i < WIDTH; i = i+1)
          begin : channel
            wire [WIDTH+(0-1):1] inh_group;

            for (j = 0; j < (WIDTH+(0-1)); j = j+1)
                begin : last_master
                  assign inh_group[j+1] = dbl_last_master_ns[j+i] && 
                          |dbl_req[(0-1)+(WIDTH+i):(j+i)+1];
                end
            
            always @(inh_group)
                inhibit[i] = |inh_group;
          end
  endgenerate

  input  disable_grant;

  output wire [WIDTH+(0-1):0] grant_ns;

  assign grant_ns = req & ({WIDTH{~disable_grant}} & ~inhibit);
  output reg [WIDTH+(0-1):0] grant_r;

  
  always @(posedge clk)  grant_r <= #TCQ grant_ns;
  input  [WIDTH+(0-1):0] current_master;

  input  upd_last_master;

  reg  [WIDTH+(0-1):0] last_master_r;

  localparam  ONE = 1<<<WIDTH+(0-1);

  assign last_master_ns = rst ? ONE[0 +: WIDTH] : 
                          upd_last_master ? current_master : last_master_r;
  
  always @(posedge clk)
      last_master_r <= #TCQ last_master_ns;
endmodule

