#include<msp430.h>
#include"src/setclock.h"
#include"src/AmplifierNonlinearDistortion.h"

void Init();//³õÊ¼»¯º¯Êı
char KeyChar(unsigned char key_value);//¼üÅÌ×Ö·û×ª»»º¯Êı

int main(void)
{
    Init();

    while (1)
    {
        //ÆµÓò Ê±Óò
    }
}

//fre=100Hz
#pragma vector=TIMER0_A0_VECTOR
__interrupt void TIMER0_A0_ISR(void)
{
    Key();
    Display_Distortion_Degree();

    static int i = 0;
    if(i == 0)//10Hz
    {
        NameRoll();
    }
    i = (i + 1) % 10;
}
void Init()//³õÊ¼»¯º¯Êı
{
    WDTCTL = WDTPW | WDTHOLD;   // stop watchdog timer
    SetClock_MCLK12MHZ_SMCLK12MHZ_ACLK32_768K();

    BUS_Init();
    Lcd_Init();
    Display();

    TA0CTL = ID_2 + TASSEL_2 + MC_1 + TACLR;//12->3MHz
    TA0EX0 |= TAIDEX_2;//3->1MHz
    TA0CCR0 = 10000 - 1; //fre=1M/10000=100Hz
    TA0CCTL0 = CCIE;

    __bis_SR_register(GIE);
}

char KeyChar(unsigned char key_value)//¼üÅÌ×Ö·û×ª»»º¯Êı
{
    char key_char;
    switch(key_value)
    {
    case 1:
        key_char = '1';
        break;
    case 2:
        key_char = '2';
        break;
    case 3:
        key_char = '3';
        break;
    case 4:
        key_char = 'A';
        break;
    case 5:
        key_char = '4';
        break;
    case 6:
        key_char = '5';
        break;
    case 7:
        key_char = '6';
        break;
    case 8:
        key_char = 'B';
        break;
    case 9:
        key_char = '7';
        break;
    case 10:
        key_char = '8';
        break;
    case 11:
        key_char = '9';
        break;
    case 12:
        key_char = 'C';
        break;
    case 13:
        key_char = '*';
        break;
    case 14:
        key_char = '0';
        break;
    case 15:
        key_char = '#';
        break;
    case 16:
        key_char = 'D';
        break;
    default:
        key_char = 'N';
        break;
    }

    return key_char;
}
