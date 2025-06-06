
module znmi(input  wire rst_n,
            input  wire fclk,
            input  wire zpos,
            input  wire zneg,
            input  wire int_start,
            input  wire [1:0] set_nmi,
            input  wire imm_nmi,
            input  wire clr_nmi,
            input  wire rfsh_n,
            input  wire m1_n,
            input  wire mreq_n,
            input  wire csrom,
            input  wire [15:0] a,
            output reg in_nmi,
            output wire gen_nmi);

  reg  [1:0] set_nmi_r;
  wire set_nmi_now;
  reg  imm_nmi_r;
  wire imm_nmi_now;
  reg  pending_nmi;
  reg  in_nmi_2;
  reg  [1<<1:0] nmi_count;
  reg  [1:0] clr_count;
  reg  pending_clr;
  reg  last_m1_rom;
  reg  last_m1_0066;
  wire nmi_start;
  reg  m1_n_reg,mreq_n_reg;
  reg  [1:0] rfsh_n_reg;

  
  always @(posedge fclk)
      if (zpos) rfsh_n_reg[0] <= rfsh_n;
        
  
  always @(posedge fclk)
      rfsh_n_reg[1] <= rfsh_n_reg[0];
  
  always @(posedge fclk)
      if (zpos) m1_n_reg <= m1_n;
        
  
  always @(posedge fclk)
      if (zneg) mreq_n_reg <= mreq_n;
        
  wire  was_m1 = ~(m1_n_reg | mreq_n_reg);

  reg  was_m1_reg;

  
  always @(posedge fclk)  was_m1_reg <= was_m1;
  
  always @(posedge fclk)
      if (!was_m1_reg && was_m1) last_m1_rom <= (a[15:14] == 2'b00) && csrom;
        
  
  always @(posedge fclk)
      if (!was_m1_reg && was_m1) last_m1_0066 <= a[15:0] == 16'h0066;
        
  
  always @(posedge fclk)  set_nmi_r <= set_nmi;
  assign set_nmi_now = |(~set_nmi & set_nmi_r);
  
  always @(posedge fclk)  imm_nmi_r <= imm_nmi;
  assign imm_nmi_now = |(imm_nmi & ~imm_nmi_r);
  
  always @(posedge fclk or negedge rst_n)
      if (!rst_n) pending_nmi <= 1'b0;
      else 
        begin
          if (int_start) pending_nmi <= 1'b0;
          else if (set_nmi_now) pending_nmi <= 1'b1;
            
        end
  assign nmi_start = (imm_nmi_now && pending_nmi) || 
                     (int_start && pending_nmi) || imm_nmi_now;
  
  always @(posedge fclk)
      if (clr_nmi) clr_count <= 2'd3;
      else if (clr_count[1] && (!rfsh_n_reg[0] && rfsh_n_reg[1])) clr_count <= (0-2'd1)+clr_count;
        
  
  always @(posedge fclk)
      if (clr_nmi) pending_clr <= 1'b1;
      else if (!clr_count[1]) pending_clr <= 1'b0;
        
  
  always @(posedge fclk or negedge rst_n)
      if (!rst_n) in_nmi_2 <= 1'b0;
      else 
        begin
          if (!in_nmi && (last_m1_rom && nmi_start)) in_nmi_2 <= 1'b1;
          else if (last_m1_0066 && (!rfsh_n_reg[0] && rfsh_n_reg[1])) in_nmi_2 <= 1'b0;
            
        end
  
  always @(posedge fclk or negedge rst_n)
      if (!rst_n) in_nmi <= 1'b0;
      else 
        begin
          if (!clr_count[1] && pending_clr) in_nmi <= 1'b0;
          else if (((!rfsh_n_reg[0] && rfsh_n_reg[1]) || nmi_start) && 
                   (nmi_start || last_m1_0066) && 
                   ((!last_m1_rom && !in_nmi && nmi_start) || 
((!last_m1_rom && !in_nmi && in_nmi_2) || 
(last_m1_0066 && 
(in_nmi_2 && (!rfsh_n_reg[0] && rfsh_n_reg[1])))))) in_nmi <= 1'b1;
            
        end
  
  always @(posedge fclk or negedge rst_n)
      if (!rst_n) nmi_count <= 3'b000;
      else if (!in_nmi && nmi_start) nmi_count <= 3'b111;
      else if (nmi_count[1<<1] && zpos) nmi_count <= nmi_count-3'd1;
        
  assign gen_nmi = nmi_count[1<<1];
endmodule

