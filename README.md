
# Table of Contents

1.  [Species Distribution Modeling of the Beetle <span class="underline">A. tumida</span>](#org7dfcba7)
    1.  [Literature](#orgce35690)
    2.  [Introduction](#orgea6a7ae)
    3.  [Review by Martin G.](#orgd20de6a)
    4.  [Записки (Bulgarian)](#orgabb8b5d)
    5.  [Models](#org03c6370)
        1.  [M1](#orgbe1685e)
        2.  [M2](#org6179836)
    6.  [Какво трябва да се направи?](#orgfd6eebe)


<a id="org7dfcba7"></a>

# Species Distribution Modeling of the Beetle <span class="underline">A. tumida</span>


<a id="orgce35690"></a>

## Literature

<https://www.molecularecologist.com/2013/04/species-distribution-models-in-r/>


<a id="orgea6a7ae"></a>

## Introduction

<span class="underline">Aetina tumida</span> is an invasive beetle species that is a parasite on the honey bee, <span class="underline">Apis melifera</span>. Its original home is South Africa. It has already appeared in the U.S.A. and in parts of Europe (Italy). We are trying to model its future distribution using MaxEnt environmental niche modeling.

We have compiled occurrsence data in the \`samples\` folder. Sources: Italian databases, GBIF.

We have compiled environmental data in the \`environmental-layers\` folder. We have the 12 bioclimatic variables from htttp://bioclim.org and we also have soil moisture data downloaded form the European Space Agency (ESA).

<https://m.esa.int/Our_Activities/Observing_the_Earth/Space_for_our_climate/Nearly_four_decades_of_soil_moisture_data_now_available>)

The soil moisture data is summarized as maximum, minimum, and average over the last five years.

We have run several analyses, which are compressed in the \`output\` folder.


<a id="orgd20de6a"></a>

## Review by Martin G.

1.  The most important is to select variables that are ecologically realistic: it means that the variable should have a likely importance on the ecology of the species.

2.  Second, I advise to avoid the use of annual averages such as bio1 or bio12 in worldclim: Indeed, the average annual temperature does not reflect "stress" for the species. Actually two distinct localities with very different minimum and maximum temperatures could have the same annual average. Thus, my advise is to use minimal and maximal temperatures (such as bio 5, bio6, bio10 or bio 11) to really reflect putative physiological limits of the species. You can apply the same way of thinking to precipitation variables.

3.  Please try to use non-correlated variables (Pearson correlation < 0.70 approx) because correlation can give spurious predictions.

4.  For invasive species range forecasting, my advise is to use a small descriptors dataset to enhance model transferability in other geographic regions: A model with too many variables will be overparametthe rized and then a bad predictor of worldwide distribution.

5.  Once you have selected the climate variables based on my previous recommendations, you can eventually test for the predictive power of different combinations of climate descriptors and select the climate dataset that shows the best predictive power. This step is not mandatory but could be helpfull.


<a id="orgabb8b5d"></a>

## Записки (Bulgarian)

Избор на модел по препоръките на Мартин.

1.  Най важен е изборът на променливи, които да са екологично реалистични.

БЕЛЕЖКА КЪМ ПАВЕЛ: Можеш ли да напишеш няколко абзаца, защо и по какъв начин точно именно температурата, валежите и влажността на почват играят роля при физиологичния цикъл на <span class="underline">A. tumida</span>?

1.  Второ, Мартин препоръчва да не се използват средно-годишни стойности като BIO1 и BIO12 от Worldclim: съображанията му са, че средната годишна температура не оказва "стрес" на видовете. Например, две различни местообитания с много различни минимални и максимални температури могат да имат същитата средно-годишна стойност. Неговият съвет е да се използват минимални и максимални температури (като as BIO5, BIO6, BIO10 и BIO11), за да се изследват предполагаемите физиологични граници на вида. Същата логика може да се приложи и към променливите, свързани с влажността.

2.  Да се използват променливи, които не са силно корелирани (pearson < .7), защото корелацията може да доведе до лъжливи резултати.

3.  За да се предскаже предполагаемото разпространие на вида за даден район, Мартин препоръчва да се изпозлват сравнително малко обяснителни променливи, за да се подобри трансферируемостта на модела в други географски ширини: модел с прекално много променливи е свръх-параметризиран и е лош предиктор за разпространието по целия глобус.

4.  След избор на модел, стъпвайки на горините препоръки, Мартин препоръчва да се тества predictive power (мощността) на различни комбинации от променливи и да се избере моделът с най-голяма мощност. Тази стъпка не е задължителна.

На базата на тези препоръки съм направил два модела M1 и M2, които са в Гитхъб хранилището на проекта
<https://github.com/vsenderov/a-tumida-sdd/tree/master/output>

Първият модел включва БИО5,6,10,11,13,14,16,17,почва макс и почва мин, а вторият прехва от първия модел 11,13,5,6,и 14, защото са много близки до другите променливи. На базата със QGIS (безплатна програма) на тях направих следната карта (също в хранилището).


<a id="org03c6370"></a>

## Models


<a id="orgbe1685e"></a>

### M1

The output of the model is in <https://github.com/vsenderov/a-tumida-sdd/tree/master/output/m1>

Base on Martin's suggestions, we have included the following variables marked with +.

BIO1    = Annual Mean Temperature = Средна годишна температура
BIO4    = Temperature Seasonality (standard deviation \*100) = сезоналност на температура 

-   BIO5  = Max Temperature of Warmest Month = максимална температура на най-горещия месец
-   BIO6  = Min Temperature of Coldest Month = минимална температура на най-студения месец
-   BIO10 = Mean Temperature of Warmest Quarter = средна темп. на най-горещо 4-м
-   BIO11 = Mean Temperature of Coldest Quarter = ср. темп. най-студ. 4м.

BIO12   = Annual Precipitation = общо годишни валежи

-   BIO13  = Precipitation of Wettest Month = валежи през най-влажен месец
-   BIO14  = Precipitation of Driest Month = валежи през най-сух месец
-   BIO16  = Precipitation of Wettest Quarter = валежи най-влажно 4м
-   BIO17 = Precipitation of Driest Quarter = валежи най-сухо 4м

BIO15 = Precipitation Seasonality (Coefficient of Variation) = сезоналност валежа (вариация)
SOIL-MEAN = средно  валежи (последни 5 г.) Soil: 2014-2018

-   SOIL-MAX  = максимални валежи (последни 5 г.) Soil: 2014-2018
-   SOIL-MIN  = минимални валежи  (последни 5 г.) Soil: 2014-2018

BIO7 = Temperature Annual Range (BIO5-BIO6) = диапазон на годишната температура 
BIO8 = Mean Temperature of Wettest Quarter = средна температура на четиримесечието, през което има най-много валежи
BIO9 = Mean Temperature of Driest Quarter = средна темп. на най-сухо 4-м
BIO2 = Mean Diurnal Range (Mean of monthly (max temp - min temp)) = средна разлика между максималната и минималната температуза на база месец
BIO3 = Isothermality (BIO2/BIO7) (\* 100) = изотермалност BIO2 / BIO7
BIO18 = Precipitation of Warmest Quarter = валежи най-топло 4м
BIO19 = Precipitation of Coldest Quarter = валежи най-студено 4М


<a id="org6179836"></a>

### M2

Output: <https://github.com/vsenderov/a-tumida-sdd/tree/master/output/m2>

We ranked the variables in order of importance produced by MaxEnt and then used the script under `R/var-importance.R` to calculate Pearson's correlation coefficient and ended up removing the following variables:

-   BIO13 beacause correlation with BIO16 > 0.7
-   BIO11, - BIO5, - BIO6 because correlation with BIO10 > 0.7
-   BIO14 because correlation with BIO17 > 0.7


<a id="orgfd6eebe"></a>

## Какво трябва да се направи?

1.  да се намерят данни за влага и температура на почвата (евентуално от

2.да се добавят нови данни за Италия за местонаходиша

1.  да изпълни моделът с
    1, 5, 6 (за температура)

и годишен валеж (12)
и данните за влажност и темп. на почвата

1.  Оформление на резултатите

а) графика за света
б) графика за Европа и Турция
в) графика за българие
д) Да се напише ръкопис на статията

1.  Да помолим Андреа да погледне ръкописа

