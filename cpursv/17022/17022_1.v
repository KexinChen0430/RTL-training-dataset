
module opccpu(inout  [7:0] data,
              output [10:0] address,
              output rnw,
              input  clk,
              input  reset_b);

  parameter 
       FETCH0 = 0,
       FETCH1 = 1,
       RDMEM  = 2,
       RDMEM2 = 3,
       EXEC   = 4;
  parameter 
       AND = 5'bx0000,
       LDA = 5'bx0001,
       NOT = 5'bx0010,
       ADD = 5'bx0011;
  parameter  LDAP = 5'b01001, STA = 5'b11000, STAP = 5'b01000;
  parameter 
       JPC = 5'b11001,
       JPZ = 5'b11010,
       JP  = 5'b11011,
       JSR = 5'b11100;
  parameter  RTS = 5'b11101, LXA = 5'b11110;
  reg  [10:0] OR_q,PC_q;
  reg  [7:0] ACC_q;
  reg  [2:0] FSM_q;
  reg  [4:0] IR_q;
  reg  [2:0] LINK_q;
  wire 
       writeback_w = 
((IR_q == STAP) || ((IR_q == STA) && (FSM_q == EXEC))) && (FSM_q == EXEC) & reset_b;

  assign rnw = ~writeback_w;
  assign data = writeback_w ? ACC_q : 8'bz;
  assign address = ((FSM_q == RDMEM) || (FSM_q == RDMEM2) || writeback_w) ? OR_q : PC_q;
  
  always @(posedge clk or negedge reset_b)
      if (!reset_b) FSM_q <= FETCH0;
      else 
        case (FSM_q)

          FETCH0: FSM_q <= FETCH1;

          FETCH1: FSM_q <= IR_q[4] ? EXEC : RDMEM;

          RDMEM: FSM_q <= (IR_q == LDAP) ? RDMEM2 : EXEC;

          RDMEM2: FSM_q <= EXEC;

          EXEC: FSM_q <= FETCH0;

        endcase

  
  always @(posedge clk)
      begin
        IR_q <= (FSM_q == FETCH0) ? data[7:3] : IR_q;
        OR_q[10:8] <= (FSM_q == FETCH0) ? data[2:0] : 
                     (FSM_q == RDMEM) ? 3'b0 : OR_q[10:8];
        OR_q[7:0] <= data;
        if (FSM_q == EXEC) 
          casex (IR_q)

            JSR: {LINK_q,ACC_q} <= PC_q;

            LXA: {LINK_q,ACC_q} <= {ACC_q[2:0],5'b0,LINK_q};

            AND: {LINK_q[0],ACC_q} <= {1'b0,ACC_q & OR_q[7:0]};

            NOT: ACC_q <= ~OR_q[7:0];

            LDA: ACC_q <= OR_q[7:0];

            LDAP: ACC_q <= OR_q[7:0];

            ADD: {LINK_q[0],ACC_q} <= (OR_q[7:0]+ACC_q)+LINK_q[0];

            default: {LINK_q[0],ACC_q} <= {LINK_q[0],ACC_q};

          endcase

          
      end
  
  always @(posedge clk or negedge reset_b)
      if (!reset_b) PC_q <= 11'h100;
      else if ((FSM_q == FETCH1) || (FSM_q == FETCH0)) PC_q <= PC_q+1;
      else 
        case (IR_q)

          JP: PC_q <= OR_q;

          JPC: PC_q <= LINK_q[0] ? OR_q : PC_q;

          JPZ: PC_q <= ~|ACC_q ? OR_q : PC_q;

          JSR: PC_q <= OR_q;

          RTS: PC_q <= {LINK_q,ACC_q};

          default: PC_q <= PC_q;

        endcase

endmodule

