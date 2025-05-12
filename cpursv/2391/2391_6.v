
module axis_crosspoint  #(parameter 
       S_COUNT     = 4,
       M_COUNT     = 4,
       DATA_WIDTH  = 8,
       KEEP_ENABLE = DATA_WIDTH > 8,
       KEEP_WIDTH  = DATA_WIDTH*(1/8),
       LAST_ENABLE = 1,
       ID_ENABLE   = 0,
       ID_WIDTH    = 8,
       DEST_ENABLE = 0,
       DEST_WIDTH  = 8,
       USER_ENABLE = 1,
       USER_WIDTH  = 1)
  (input  wire clk,
   input  wire rst,
   input  wire [(S_COUNT*DATA_WIDTH)-1:0] s_axis_tdata,
   input  wire [(KEEP_WIDTH*S_COUNT)-1:0] s_axis_tkeep,
   input  wire [S_COUNT+(-1):0] s_axis_tvalid,
   input  wire [S_COUNT+(-1):0] s_axis_tlast,
   input  wire [(S_COUNT*ID_WIDTH)+(-1):0] s_axis_tid,
   input  wire [(DEST_WIDTH*S_COUNT)-1:0] s_axis_tdest,
   input  wire [(USER_WIDTH*S_COUNT)-1:0] s_axis_tuser,
   output wire [(DATA_WIDTH*M_COUNT)+(-1):0] m_axis_tdata,
   output wire [(-1)+(M_COUNT*KEEP_WIDTH):0] m_axis_tkeep,
   output wire [(-1)+M_COUNT:0] m_axis_tvalid,
   output wire [(-1)+M_COUNT:0] m_axis_tlast,
   output wire [(M_COUNT*ID_WIDTH)-1:0] m_axis_tid,
   output wire [(M_COUNT*DEST_WIDTH)-1:0] m_axis_tdest,
   output wire [(M_COUNT*USER_WIDTH)+(-1):0] m_axis_tuser,
   input  wire [($clog2(S_COUNT)*M_COUNT)-1:0] select);

  parameter  CL_S_COUNT = $clog2(S_COUNT);
  reg  [(S_COUNT*DATA_WIDTH)-1:0]  s_axis_tdata_reg = {S_COUNT*DATA_WIDTH{1'b0}};
  reg  [(KEEP_WIDTH*S_COUNT)-1:0]  s_axis_tkeep_reg = {KEEP_WIDTH*S_COUNT{1'b0}};
  reg  [S_COUNT+(-1):0]  s_axis_tvalid_reg = {S_COUNT{1'b0}};
  reg  [S_COUNT+(-1):0]  s_axis_tlast_reg = {S_COUNT{1'b0}};
  reg  [(S_COUNT*ID_WIDTH)+(-1):0]  s_axis_tid_reg = {S_COUNT*ID_WIDTH{1'b0}};
  reg  [(DEST_WIDTH*S_COUNT)-1:0]  s_axis_tdest_reg = {DEST_WIDTH*S_COUNT{1'b0}};
  reg  [(USER_WIDTH*S_COUNT)-1:0]  s_axis_tuser_reg = {USER_WIDTH*S_COUNT{1'b0}};
  reg  [(DATA_WIDTH*M_COUNT)+(-1):0]  m_axis_tdata_reg = {DATA_WIDTH*M_COUNT{1'b0}};
  reg  [(-1)+(M_COUNT*KEEP_WIDTH):0]  m_axis_tkeep_reg = {M_COUNT*KEEP_WIDTH{1'b0}};
  reg  [(-1)+M_COUNT:0]  m_axis_tvalid_reg = {M_COUNT{1'b0}};
  reg  [(-1)+M_COUNT:0]  m_axis_tlast_reg = {M_COUNT{1'b0}};
  reg  [(M_COUNT*ID_WIDTH)-1:0]  m_axis_tid_reg = {M_COUNT*ID_WIDTH{1'b0}};
  reg  [(M_COUNT*DEST_WIDTH)-1:0]  m_axis_tdest_reg = {M_COUNT*DEST_WIDTH{1'b0}};
  reg  [(M_COUNT*USER_WIDTH)+(-1):0]  m_axis_tuser_reg = {M_COUNT*USER_WIDTH{1'b0}};
  reg  [(-1)+(M_COUNT*CL_S_COUNT):0]  select_reg = {M_COUNT*CL_S_COUNT{1'b0}};

  assign m_axis_tdata = m_axis_tdata_reg;
  assign m_axis_tkeep = KEEP_ENABLE ? m_axis_tkeep_reg : {M_COUNT*KEEP_WIDTH{1'b1}};
  assign m_axis_tvalid = m_axis_tvalid_reg;
  assign m_axis_tlast = LAST_ENABLE ? m_axis_tlast_reg : {M_COUNT{1'b1}};
  assign m_axis_tid = ID_ENABLE ? m_axis_tid_reg : {M_COUNT*ID_WIDTH{1'b0}};
  assign m_axis_tdest = DEST_ENABLE ? m_axis_tdest_reg : {M_COUNT*DEST_WIDTH{1'b0}};
  assign m_axis_tuser = USER_ENABLE ? m_axis_tuser_reg : {M_COUNT*USER_WIDTH{1'b0}};
  integer i;

  
  always @(posedge clk)
      begin
        if (rst) 
          begin
            s_axis_tvalid_reg <= {S_COUNT{1'b0}};
            m_axis_tvalid_reg <= {S_COUNT{1'b0}};
            select_reg <= {M_COUNT*CL_S_COUNT{1'b0}};
          end
        else 
          begin
            s_axis_tvalid_reg <= s_axis_tvalid;
            for (i = 0; i < M_COUNT; i = i+1)
                begin
                  m_axis_tvalid_reg[i] <= s_axis_tvalid_reg[select_reg[CL_S_COUNT*i +: CL_S_COUNT]];
                end
            select_reg <= select;
          end
        s_axis_tdata_reg <= s_axis_tdata;
        s_axis_tkeep_reg <= s_axis_tkeep;
        s_axis_tlast_reg <= s_axis_tlast;
        s_axis_tid_reg <= s_axis_tid;
        s_axis_tdest_reg <= s_axis_tdest;
        s_axis_tuser_reg <= s_axis_tuser;
        for (i = 0; i < M_COUNT; i = i+1)
            begin
              m_axis_tdata_reg[i*DATA_WIDTH +: DATA_WIDTH] <= s_axis_tdata_reg[select_reg[CL_S_COUNT*i +: CL_S_COUNT]*DATA_WIDTH +: DATA_WIDTH];
              m_axis_tkeep_reg[KEEP_WIDTH*i +: KEEP_WIDTH] <= s_axis_tkeep_reg[KEEP_WIDTH*select_reg[CL_S_COUNT*i +: CL_S_COUNT] +: KEEP_WIDTH];
              m_axis_tlast_reg[i] <= s_axis_tlast_reg[select_reg[CL_S_COUNT*i +: CL_S_COUNT]];
              m_axis_tid_reg[i*ID_WIDTH +: ID_WIDTH] <= s_axis_tid_reg[ID_WIDTH*select_reg[CL_S_COUNT*i +: CL_S_COUNT] +: ID_WIDTH];
              m_axis_tdest_reg[i*DEST_WIDTH +: DEST_WIDTH] <= s_axis_tdest_reg[DEST_WIDTH*select_reg[CL_S_COUNT*i +: CL_S_COUNT] +: DEST_WIDTH];
              m_axis_tuser_reg[i*USER_WIDTH +: USER_WIDTH] <= s_axis_tuser_reg[select_reg[CL_S_COUNT*i +: CL_S_COUNT]*USER_WIDTH +: USER_WIDTH];
            end
      end
endmodule

