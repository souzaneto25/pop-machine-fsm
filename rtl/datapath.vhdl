library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

ENTITY datapath IS
    PORT (
        --clock e reset de entradas
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        --carrega o resultado da soma no registrador
        tot_ld : IN STD_LOGIC;
        --aplica o clear no registrador tot
        tot_clr : IN STD_LOGIC;
        --preço do refrigerante
        s : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        --preço da moeda
        a : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        --indica se o total é menor que o preço do refri
        tot_lt_s : OUT STD_LOGIC
    );
END ENTITY datapath;

ARCHITECTURE arch OF datapath IS

    --sinal da saída do total em 8 bits
    SIGNAL tot : STD_LOGIC_VECTOR(7 DOWNTO 0);
    --sinal da soma em 8 bits
    SIGNAL soma : STD_LOGIC_VECTOR(7 DOWNTO 0);

BEGIN

    --FUNCIONAMENTO DO REGISTRADOR
    registrador : PROCESS (clk, rst)
    BEGIN
        --SE O RESET FOR 1 ELE VAI ZERAR O TOTAL
        IF rst = '1' THEN
            tot <= b"00000000";
            --SENÃO SE O CLK ESTIVER SUBINDO
        ELSIF rising_edge(clk) THEN
            --SE CLEAR FOR 1 ELE VAI ZERAR O TOTAL
            IF tot_clr = '1' THEN
                tot <= b"00000000";
                --SENÃO SE O LOAD FOR 1 ELE VAI RETORNAR O VALOR DA SOMA
            ELSIF tot_ld = '1' THEN
                tot <= soma;
            END IF;
        END IF;
    END PROCESS registrador;

    --para somar ou comparar os sinais é necessario torna-los unsigned (sem sinal) e depois retornalos ao valor que eram

    --FUNCIONAMENTO DO COMPARADOR
    tot_lt_s <= '1' WHEN unsigned(tot) < unsigned(s) ELSE '0';

    --FUNCIONAMENTO DO SOMADOR
    soma <= STD_LOGIC_VECTOR(unsigned(tot) + unsigned(a));

END ARCHITECTURE arch;