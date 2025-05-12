module Flow_Control (
    reg_PC0_next,
    reg_PC1_next,
    reg_PC2_next,
    reg_MSR0_next,
    reg_MSR1_next,
    reg_MSR2_next,
    val_offset,
    val_test,
    val_jump,
    reg_PC0,
    reg_PC1,
    reg_PC2,
    reg_MSR0,
    reg_MSR1,
    reg_MSR2,
    opcode,
    condition,
    interrupt,
    vector
);
    `include "definition/Definition.v"
    output reg [WORD-1:0] reg_PC0_next;
    output reg [WORD-1:0] reg_PC1_next;
    output reg [WORD-1:0] reg_PC2_next;
    output reg [WORD-1:0] reg_MSR0_next;
    output reg [WORD-1:0] reg_MSR1_next;
    output reg [WORD-1:0] reg_MSR2_next;
    input [WORD-1:0] val_offset;
    input [WORD-1:0] val_test;
    input [WORD-1:0] val_jump;
    input [WORD-1:0] reg_PC0;
    input [WORD-1:0] reg_PC1;
    input [WORD-1:0] reg_PC2;
    input [WORD-1:0] reg_MSR0;
    input [WORD-1:0] reg_MSR1;
    input [WORD-1:0] reg_MSR2;
    input [FLOW_OPCODE_WIDTH-1:0] opcode;
    input [CONDITION_WIDTH-1:0] condition;
    input interrupt; 
    input [WORD-1:0] vector; 
    reg [WORD-1:0] A;
    reg [WORD-1:0] B;
    reg [WORD-1:0] C;
    reg [WORD-1:0] X;
    reg [WORD-1:0] Y;
    reg [WORD-1:0] Z;
    reg condmet; 
    always @(*) begin
        case(condition)
            COND_MSR_Z      : begin condmet <=  reg_MSR0[BIT_MSR_Z]; end
            COND_MSR_NOTZ   : begin condmet <= !reg_MSR0[BIT_MSR_Z]; end
            COND_MSR_C      : begin condmet <=  reg_MSR0[BIT_MSR_C]; end
            COND_MSR_NOTC   : begin condmet <= !reg_MSR0[BIT_MSR_C]; end
            COND_MSR_V      : begin condmet <=  reg_MSR0[BIT_MSR_V]; end
            COND_MSR_NOTV   : begin condmet <= !reg_MSR0[BIT_MSR_V]; end
            COND_MSR_N      : begin condmet <=  reg_MSR0[BIT_MSR_N]; end
            COND_MSR_NOTN   : begin condmet <= !reg_MSR0[BIT_MSR_N]; end
            COND_MSR_M      : begin condmet <=  reg_MSR0[BIT_MSR_M]; end
            COND_MSR_NOTM   : begin condmet <= !reg_MSR0[BIT_MSR_M]; end
            COND_REG_Z      : begin condmet <= !(|val_test);         end 
            COND_REG_NOTZ   : begin condmet <=  (|val_test);         end 
            COND_REG_N      : begin condmet <=  val_test[WORD-1];    end 
            COND_REG_NOTN   : begin condmet <= !val_test[WORD-1];    end 
            default         : begin condmet <= 0;                     end 
        endcase
        if(condmet) begin
            case(opcode)
                default             : begin A <= reg_PC0;               B <= reg_PC1;               C <= reg_PC2; end
                FLOW_STEP           : begin A <= reg_PC0 + WORDBYTE;   B <= reg_PC1;               C <= reg_PC2; end
                FLOW_HOLD           : begin A <= reg_PC0;               B <= reg_PC1;               C <= reg_PC2; end
                FLOW_RETURN         : begin A <= reg_PC1 + val_offset; B <= reg_PC2;               C <= reg_PC2; end
                FLOW_BRANCH         : begin A <= reg_PC0 + val_offset; B <= reg_PC1;               C <= reg_PC2; end
                FLOW_BRANCH_LINK    : begin A <= reg_PC0 + val_offset; B <= reg_PC0 + WORDBYTE;    C <= reg_PC1; end
                FLOW_JUMP           : begin A <= val_jump;             B <= reg_PC1;               C <= reg_PC2; end
                FLOW_JUMP_LINK      : begin A <= val_jump;             B <= reg_PC0 + WORDBYTE;    C <= reg_PC1; end
            endcase
            case(opcode)
                default             : begin X <= reg_MSR0; Y <= reg_MSR1; Z <= reg_MSR2; end
                FLOW_STEP           : begin X <= reg_MSR0; Y <= reg_MSR1; Z <= reg_MSR2; end
                FLOW_HOLD           : begin X <= reg_MSR0; Y <= reg_MSR1; Z <= reg_MSR2; end
                FLOW_RETURN         : begin X <= reg_MSR1; Y <= reg_MSR2; Z <= reg_MSR2; end
                FLOW_BRANCH         : begin X <= reg_MSR0; Y <= reg_MSR1; Z <= reg_MSR2; end
                FLOW_BRANCH_LINK    : begin X <= 0;        Y <= reg_MSR0; Z <= reg_MSR1; end
                FLOW_JUMP           : begin X <= reg_MSR0; Y <= reg_MSR1; Z <= reg_MSR2; end
                FLOW_JUMP_LINK      : begin X <= 0;        Y <= reg_MSR0; Z <= reg_MSR1; end
            endcase
        end
        else begin
            A <= reg_PC0 + WORDBYTE;
            B <= reg_PC1;
            C <= reg_PC2;
            X <= reg_MSR0;
            Y <= reg_MSR1;
            Z <= reg_MSR2;
        end
        if(!interrupt) begin
            reg_PC0_next    <= A;
            reg_PC1_next    <= B;
            reg_PC2_next    <= C;
            reg_MSR0_next   <= X;
            reg_MSR1_next   <= Y;
            reg_MSR2_next   <= Z;
        end
        else begin
            reg_PC0_next    <= vector;
            reg_PC1_next    <= A;
            reg_PC2_next    <= B;
            reg_MSR0_next   <= 0;
            reg_MSR1_next   <= X;
            reg_MSR2_next   <= Y;
        end
    end
endmodule