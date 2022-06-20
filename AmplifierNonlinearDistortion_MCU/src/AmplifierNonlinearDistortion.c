/*
 * AmplifierNonlinearDistortion.c
 *
 *  Created on: 2022��5��16��
 *      Author: Fu Yuhao
 */
#include <msp430.h>
#include "BUS_FPGA.h"
#include"AmplifierNonlinearDistortion.h"
#include "lcd_serial.h"
#include "key.h"
#include<math.h>

int screen = 0, screen_old = 0;

void Key()
{
    static unsigned char key_value;
    static char key_char;

    static int i = 0;
    if(i == 0 || i == 30)//300ms������ʱ
    {
        i = 0;
    }
    else
    {
        i++;
    }
    key_value = read_key();
    if(key_value != 0 && i == 0)
    {
        i = 1;
        key_char = KeyChar(key_value);
        switch(screen)
        {
        case 0://������
            switch(key_char)
            {
            case '1'://��ʧ��
                IOWR(CS3, 0, 0); //0000
                screen = 1;
                Display();
                break;
            case '2'://����ʧ��
                IOWR(CS3, 0, 12); //1100
                screen = 2;
                Display();
                break;
            case '3'://�ײ�ʧ��
                IOWR(CS3, 0, 8); //1000
                screen = 3;
                Display();
                break;
            case '4'://˫��ʧ��
                IOWR(CS3, 0, 2); //0010
                screen = 4;
                Display();
                break;
            case '5'://��Խʧ��
                IOWR(CS3, 0, 1); //0001
                screen = 5;
                Display();
                break;
            default:
                break;
            }
            break;
        case 1://������ʧ��
            switch(key_char)
            {
            case 'A':
                screen_old = screen;
                screen = 6;
                Display();
                break;
            case '#'://����
                screen = 0;
                Display();
                break;
            default:
                break;
            }
            break;
        case 2://����ʧ��
            switch(key_char)
            {
            case 'A':
                screen_old = screen;
                screen = 6;
                Display();
                break;
            case '#'://����
                screen = 0;
                Display();
                break;
            default:
                break;
            }
            break;
        case 3://�ײ�ʧ��
            switch(key_char)
            {
            case 'A':
                screen_old = screen;
                screen = 6;
                Display();
                break;
            case '#'://����
                screen = 0;
                Display();
                break;
            default:
                break;
            }
            break;
        case 4://˫��ʧ��
            switch(key_char)
            {
            case 'A':
                screen_old = screen;
                screen = 6;
                Display();
                break;
            case '#'://����
                screen = 0;
                Display();
                break;
            default:
                break;
            }
            break;
        case 5://��Խʧ��
            switch(key_char)
            {
            case 'A':
                screen_old = screen;
                screen = 6;
                Display();
                break;
            case '#'://����
                screen = 0;
                Display();
                break;
            default:
                break;
            }
            break;
        case 6://Ƶ��ͼ
            switch(key_char)
            {
            case '#'://����
                screen = screen_old;
                Display();
                break;
            default:
                break;
            }
            break;
        default:
            break;
        }
        if(key_char == '*')
        {
            screen = 0;
            Display();
        }
    }
}
void Display()
{
    lcd_clear();
    //DispDec57At(6, 116, key_value, 2);
    //�Ŵ���������ʧ��
    // 1 / 2 / 3 / 4 / 5
    // ��ʧ�� / ����ʧ�� / �ײ�ʧ�� / ˫��ʧ�� / ��Խʧ��
    //By �������½���ġ�������
    // * / #
    // ��ҳ / ����
    if(screen == 0)
    {
        disp_graph_16x16(0, 0, Fang);
        disp_graph_16x16(0, 16, Da);
        disp_graph_16x16(0, 32, Qi);
        disp_graph_16x16(0, 48, Fei);
        disp_graph_16x16(0, 64, Xian);
        disp_graph_16x16(0, 80, Xing);
        disp_graph_16x16(0, 96, Shi);
        disp_graph_16x16(0, 112, Zhen);

        disp_graph_16x16(2, 0, Wu);
        disp_graph_16x16(2, 16, Shi);
        disp_graph_16x16(2, 32, Zhen);
        DispStringAt(2, 48, "/");
        disp_graph_16x16(2, 56, Ding);
        disp_graph_16x16(2, 72, Bu);
        DispStringAt(2, 88, "/");
        disp_graph_16x16(2, 96, Di);
        disp_graph_16x16(2, 112, Bu);

        disp_graph_16x16(4, 0, Shuang);
        disp_graph_16x16(4, 16, Xiang);
        DispStringAt(4, 32, "/");
        disp_graph_16x16(4, 40, Jiao);
        disp_graph_16x16(4, 56, Yue);
    }
    //������ʧ��
    if(screen == 1)
    {
        disp_graph_16x16(0, 0, Wu);
        disp_graph_16x16(0, 16, Ming);
        disp_graph_16x16(0, 32, Xian2);
        disp_graph_16x16(0, 48, Shi);
        disp_graph_16x16(0, 64, Zhen);

        disp_graph_16x16(2, 0, Shi);
        disp_graph_16x16(2, 16, Zhen);
        disp_graph_16x16(2, 32, Du);
        DispStringAt(2, 48, "=");
        DispStringAt(2, 72, ".");
        DispStringAt(2, 96, "%");
    }
    //����ʧ��
    else if(screen == 2)
    {
        disp_graph_16x16(0, 0, Ding);
        disp_graph_16x16(0, 16, Bu);
        disp_graph_16x16(0, 32, Shi);
        disp_graph_16x16(0, 48, Zhen);

        disp_graph_16x16(2, 0, Shi);
        disp_graph_16x16(2, 16, Zhen);
        disp_graph_16x16(2, 32, Du);
        DispStringAt(2, 48, "=");
        DispStringAt(2, 72, ".");
        DispStringAt(2, 96, "%");
    }
    //�ײ�ʧ��
    else if(screen == 3)
    {
        disp_graph_16x16(0, 0, Di);
        disp_graph_16x16(0, 16, Bu);
        disp_graph_16x16(0, 32, Shi);
        disp_graph_16x16(0, 48, Zhen);

        disp_graph_16x16(2, 0, Shi);
        disp_graph_16x16(2, 16, Zhen);
        disp_graph_16x16(2, 32, Du);
        DispStringAt(2, 48, "=");
        DispStringAt(2, 72, ".");
        DispStringAt(2, 96, "%");
    }
    //˫��ʧ��
    else if(screen == 4)
    {
        disp_graph_16x16(0, 0, Shuang);
        disp_graph_16x16(0, 16, Xiang);
        disp_graph_16x16(0, 32, Shi);
        disp_graph_16x16(0, 48, Zhen);

        disp_graph_16x16(2, 0, Shi);
        disp_graph_16x16(2, 16, Zhen);
        disp_graph_16x16(2, 32, Du);
        DispStringAt(2, 48, "=");
        DispStringAt(2, 72, ".");
        DispStringAt(2, 96, "%");
    }
    //��Խʧ��
    else if(screen == 5)
    {
        disp_graph_16x16(0, 0, Jiao);
        disp_graph_16x16(0, 16, Yue);
        disp_graph_16x16(0, 32, Shi);
        disp_graph_16x16(0, 48, Zhen);

        disp_graph_16x16(2, 0, Shi);
        disp_graph_16x16(2, 16, Zhen);
        disp_graph_16x16(2, 32, Du);
        DispStringAt(2, 48, "=");
        DispStringAt(2, 72, ".");
        DispStringAt(2, 96, "%");
    }
    else if(screen == 6)
    {
        FreDomainDisplay();//Ƶ��ͼ��ʾ
    }
}

void Display_Distortion_Degree()
{
    if(screen == 1 || screen == 2 || screen == 3 || screen == 4 || screen == 5)
    {
        static unsigned int distortion_degree_array[100];
        static unsigned long distortion_degree_aver;
        static int i = 0;
        int j = 0;

        unsigned int distortion_degree_numer;//����
        unsigned int distortion_degree_denom;//��ĸ
        unsigned int distortion_degree;
        distortion_degree_numer = IORD(CS1, 0);
        distortion_degree_denom = IORD(CS2, 0);
        distortion_degree = ((long)distortion_degree_numer * 100000 / distortion_degree_denom + 5) / 10;

        distortion_degree_array[i] = distortion_degree;
        if(i == 99)
        {
            distortion_degree_aver = 0;
            for(j = 0; j < 100; j++)
            {
                distortion_degree_aver = distortion_degree_aver + distortion_degree_array[j];
            }
            distortion_degree_aver = (distortion_degree_aver + 50) / 100;
        }
        DispDecAt(2, 56, distortion_degree_aver / 100, 2);
        DispDecAt(2, 80, distortion_degree_aver % 100, 2);

        i = (i + 1) % 100;
    }
}

void NameRoll()
{
    static int bit[9] = {24, 40, 56, 80, 96, 112, 136, 152, 168};
    if(screen == 0)
    {
        int i = 0;
        if(bit[0] >= 1 && bit[0] <= 127)
        {
            disp_graph_16x16(6, bit[0], Fu);
        }
        if(bit[1] >= 1 && bit[1] <= 127)
        {
            disp_graph_16x16(6, bit[1], Yu);
        }
        if(bit[2] >= 1 && bit[2] <= 127)
        {
            disp_graph_16x16(6, bit[2], Hao);
        }
        if(bit[3] >= 1 && bit[3] <= 127)
        {
            disp_graph_16x16(6, bit[3], Lu);
        }
        if(bit[4] >= 1 && bit[4] <= 127)
        {
            disp_graph_16x16(6, bit[4], Shou);
        }
        if(bit[5] >= 1 && bit[5] <= 127)
        {
            disp_graph_16x16(6, bit[5], Wen);
        }
        if(bit[6] >= 1 && bit[6] <= 127)
        {
            disp_graph_16x16(6, bit[6], Wang);
        }
        if(bit[7] >= 1 && bit[7] <= 127)
        {
            disp_graph_16x16(6, bit[7], Le);
        }
        if(bit[8] >= 1 && bit[8] <= 127)
        {
            disp_graph_16x16(6, bit[8], Ming);
        }
        for(i = 0; i < 9; i++)
        {
            bit[i]--;
            if(bit[i] == 0)
            {
                bit[i] = 168;
            }
        }
        DispStringAt(6, 0, "By");
    }
}

void FreDomainDisplay()
{
    unsigned int dataFre[8];
    int dataFreAdj[8];
    dataFre[0] = sqrt(IORD(CS4, 0));
    dataFre[1] = sqrt(IORD(CS5, 0));
    dataFre[2] = sqrt(IORD(CS6, 0));
    dataFre[3] = sqrt(IORD(CS7, 0));
    dataFre[4] = sqrt(IORD(CS8, 0));
    dataFre[5] = sqrt(IORD(CS9, 0));
    dataFre[6] = sqrt(IORD(CS10, 0));
    dataFre[7] = sqrt(IORD(CS11, 0));

    int k;

    int max;
    for(k = 0; k < 8; k++)
    {
        max = (max < dataFre[k]) ? dataFre[k] : max;
    }
    for(k = 0; k < 8; k++)
    {
        dataFreAdj[k] = 64 * (long)dataFre[k] / max;
    }

    int i;
    int j;
    for(j = 0; j < 8; j++)
    {
        int black = dataFreAdj[j] / 16;
        int top = dataFreAdj[j] % 16;
        for(i = 6; i >= 8 - 2 * black; i = i - 2)
        {
            disp_graph_8x16(i, j * 16 + 4, Black);
        }
        if(i >= 0)
        {
            DispTop(i, j, top);
        }
    }
}
void DispTop(int i, int j, int top)
{
    const unsigned char topCode[] = {     0x00, 0x80, 0xC0, 0xE0, 0xF0, 0xF8, 0xFC, 0xFE    };
    unsigned char Top1[] =//8x16
    {
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        topCode[top], topCode[top], topCode[top], topCode[top], topCode[top], topCode[top], topCode[top], topCode[top],
    };
    unsigned char Top2[] =//8x16
    {
        topCode[top - 8], topCode[top - 8], topCode[top - 8], topCode[top - 8], topCode[top - 8], topCode[top - 8], topCode[top - 8], topCode[top - 8],
        0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
    };
    if(top <= 7)
    {
        disp_graph_8x16(i, j * 16 + 4, Top1);
    }
    else
    {
        disp_graph_8x16(i, j * 16 + 4, Top2);
    }
}
