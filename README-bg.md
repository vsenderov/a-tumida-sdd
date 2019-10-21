https://www.molecularecologist.com/2013/04/species-distribution-models-in-r/

*BIO1 = Annual Mean Temperature = СРЕДНА ГОДИШНА ТЕМПЕРАТУРА

BIO4 = Temperature Seasonality (standard deviation *100) = СЕЗОНАЛНОСТ НА ТЕМПЕРАТУРА (СТАНДАРТНО ОТКЛОНЕНИЕ * 100)

*BIO5 = Max Temperature of Warmest Month = МАКСИМАЛНА ТЕМПЕРАТУРА НА НАЙ-ГОРЕЩИЯ МЕСЕЦ

*BIO6 = Min Temperature of Coldest Month = МИНИМАЛНА ТЕМПЕРАТУРА НА НАЙ-СТУДЕНИЯ МЕСЕЦ

*BIO12 = Annual Precipitation = ОБЩО ГОДИШНИ ВАЛЕЖИ

BIO13 = Precipitation of Wettest Month = ВАЛЕЖИ ПРЕЗ НАЙ-ВЛАЖЕН МЕСЕЦ
BIO14 = Precipitation of Driest Month = ВАЛЕЖИ ПРЕЗ НАЙ-СУХ МЕСЕЦ

*BIO15 = Precipitation Seasonality (Coefficient of Variation) = СЕЗОНАЛНОСТ ВАЛЕЖА (ВАРИАЦИЯ)


Soil: 2014-2018
average
min
max


``
BIO7 = Temperature Annual Range (BIO5-BIO6) = ДИАПАЗОН НА ГОДИШНАТА ТЕМПЕРАТУРА (П5 - П6)

BIO8 = Mean Temperature of Wettest Quarter = СРЕДНА ТЕМПЕРАТУРА НА ЧЕТИРИМЕСЕЧИЕТО, ПРЕЗ КОЕТО ИМА НАЙ-МНОГО ВАЛЕЖИ

BIO9 = Mean Temperature of Driest Quarter = СРЕДНА ТЕМП. НА НАЙ-СУХО 4-М

BIO10 = Mean Temperature of Warmest Quarter = СРЕДНА ТЕМП. НА НАЙ-ГОРЕЩО 4-М

BIO11 = Mean Temperature of Coldest Quarter = СР. ТЕМП. НАЙ-СТУД. 4М.

BIO2 = Mean Diurnal Range (Mean of monthly (max temp - min temp)) = СРЕДНА РАЗЛИКА МЕЖДУ МАКСИМАЛНАТА И МИНИМАЛНАТА ТЕМПЕРАТУЗА НА БАЗА МЕСЕЦ

BIO3 = Isothermality (BIO2/BIO7) (* 100) = ИЗОТЕРМАЛНОСТ ПРОМЕНЛИВА2 / ПРОМЕНЛИВА7


BIO16 = Precipitation of Wettest Quarter = ВАЛЕЖИ НАЙ-ВЛАЖНО 4М

BIO17 = Precipitation of Driest Quarter = ВАЛЕЖИ НАЙ-СУХО 4М

BIO18 = Precipitation of Warmest Quarter = ВАЛЕЖИ НАЙ-ТОПЛО 4М

BIO19 = Precipitation of Coldest Quarter = ВАЛЕЖИ НАЙ-СТУДЕНО 4М



---------------------------------------
* BIO1 = ср. температура
BIO2 = температурен диапазон средна стойност на месечната разлика (макс темп - мин темп)
BIO3 = изотермалност
4 = сеналност (вариация)
* 5 = макс темп най-горещ месец
* 6 = мин темп най-студен месец
7 = 5 - 6
8 = средна темп на най-влажен месец
9 = средна темп на най сух мсец
10 = средна температура на най-горещо тримесечие
11 = средна темп на най-студено тримесечие

* 12 = годишен валеж
- 13 = валеж през най мокър месец
- 14 = валеж през най сух месец
15 = вариация на валежите (сезоналност)
16 = валеж през най-мокрото тримесеч.
17 = валеж през най-сухото тримесеч.
18 = валеж през най-топло тримесеч.
19 = валеж през най-студено тримесе.



Модели, които сме опитали

analiz : 


Variable	Percent contribution	Permutation importance
bioclim_12   	56.2	31.4 (годишен валеж)
bioclim_5	16.7	13.4 (най-топыл месец)
bioclim_15	10.9	22.8 (сезоналност валеж)
bioclim_1	9.3	22.6 (средна темп)
bioclim_6	4	6.9  (мнай-студен мец)
soil-min	1.5	1.5 (почва)
soil-mean	1.1	0.8
soil-max	0.2	0.6

analiz2

Variable	Percent contribution	Permutation importance
bioclim_1	43.7	11.6
soil-mean	25.5	24.4
bioclim_5	21.8	42.1
bioclim_6	5.2	19.3
soil-min	2.7	1.4
soil-max	1	1.2


Какво трябва да се направи?

1. да се намерят данни за влага и температура на почвата (евентуално от 
2.да се добавят нови данни за Италия за местонаходиша

3. да изпълни моделът с
 1, 5, 6 (за температура)
и годишен валеж (12)
и данните за влажност и темп. на почвата

4. Оформление на резултатите
а) графика за света
б) графика за Европа и Турция
в) графика за българие
д) Да се напише ръкопис на статията

5. Да помолим Андреа да погледне ръкописа







