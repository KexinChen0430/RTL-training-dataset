
module axi_traffic_gen_v2_0_regslice  #(parameter 
       DWIDTH    = 64,
       IDWIDTH   = 64,
       DATADEPTH = 3,
       IDDEPTH   = 2)
  (input  [(0-1)+DWIDTH:0] din,
   output [(0-1)+DWIDTH:0] dout,
   output [(0-1)+DWIDTH:0] dout_early,
   input  [IDWIDTH+(0-1):0] idin,
   output [IDWIDTH+(0-1):0] idout,
   output id_stable,
   output reg id_stable_ff,
   output data_stable,
   input  clk,
   input  reset);

  reg  [(0-1)+DWIDTH:0] datapath[0:(0-1)+DATADEPTH];
  reg  [IDWIDTH+(0-1):0] idpath[0:(0-1)+IDDEPTH];
  reg  [(0-1)+DATADEPTH:0] din_newpath;
  reg  [(0-1)+IDDEPTH:0] idin_newpath;
  integer ix;
  wire  din_new = din != datapath[(0-1)+DATADEPTH];
  wire  idin_new = idin != idpath[(0-1)+IDDEPTH];

  
  always @(posedge clk)
      begin
        if (reset) 
          begin
            for (ix = 0; ix < DATADEPTH; ix = 1+ix)
                datapath[ix] <= 0;
            for (ix = 0; ix < IDDEPTH; ix = 1+ix)
                idpath[ix] <= 0;
            idin_newpath <= 0;
            din_newpath <= 0;
          end
        else 
          begin
            datapath[(0-1)+DATADEPTH] <= din;
            idpath[(0-1)+IDDEPTH] <= idin;
            din_newpath[(0-1)+DATADEPTH] <= din_new;
            idin_newpath[(0-1)+IDDEPTH] <= idin_new;
            for (ix = 0; ix < ((0-1)+DATADEPTH); ix = 1+ix)
                datapath[ix] <= datapath[1+ix];
            for (ix = 0; ix < ((0-1)+DATADEPTH); ix = 1+ix)
                din_newpath[ix] <= din_newpath[1+ix];
            for (ix = 0; ix < ((0-1)+IDDEPTH); ix = 1+ix)
                idpath[ix] <= idpath[1+ix];
            for (ix = 0; ix < ((0-1)+IDDEPTH); ix = 1+ix)
                idin_newpath[ix] <= idin_newpath[1+ix];
            id_stable_ff <= id_stable;
          end
      end
  
  generate
      if (DATADEPTH > 1) 
        begin : g1
          assign dout_early = datapath[1];
        end
      else 
        begin : g2
          assign dout_early = 0;
        end
  endgenerate

  assign dout = datapath[0];
  assign idout = idpath[0];
  assign id_stable = (idin_newpath == 0) && (idin_new == 0);
  assign data_stable = din_newpath == 0;
endmodule

