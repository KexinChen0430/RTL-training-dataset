module ROM
(
    input  wire[15:0]      iAddress,       
    output reg [27:0]      oInstruction    
);
always @ ( iAddress )
begin
    case (iAddress)
        0: oInstruction = { `NOP ,24'd4000 };
        1: oInstruction = { `STO ,`R2, 16'h0001};
        2: oInstruction = { `STO ,`R1, 16'h0000};
        3: oInstruction = { `STO ,`R3, 16'h00ff };
        4: oInstruction = { `STO ,`R4, 13'b0,`GREEN};
        5: oInstruction = { `CALL ,`SUB_VGA, 16'h0000 };
        6: oInstruction = { `STO ,`R3, 16'h01ff };
        7: oInstruction = { `STO ,`R4, 13'b0,`RED};
        8: oInstruction = { `CALL ,`SUB_VGA, 16'h0000 };
        9: oInstruction = { `STO ,`R3, 16'h02ff };
        10: oInstruction = { `STO ,`R4, 13'b0,`MAGENTA};
        11: oInstruction = { `CALL ,`SUB_VGA, 16'h0000 };
        12: oInstruction = { `STO ,`R3, 16'h03ff };
        13: oInstruction = { `STO ,`R4, 13'b0,`BLUE};
        14: oInstruction = { `CALL ,`SUB_VGA, 16'h0000 };
        15: oInstruction = { `NOP , 24'd4000      };
        16: oInstruction = { `JMP , 8'd15, 16'b0   };
        17: oInstruction = { `WVM , 8'd0,`R4,`R1};
        18: oInstruction = { `ADD ,`R1,`R1,`R2};
        19: oInstruction = { `BLE , 8'd17,`R1,`R3  };
        20: oInstruction = { `RET , 24'd0 };
        default:
            oInstruction = { `LED ,  24'b10101010 };        
    endcase
end
endmodule