﻿--*****************************--
--***** © by Kevin Saukel *****--
--**** All rights reserved ****--
--******** 01.08.2016 *********--
--*****************************--

local Shader = {}
Shader[1] = { [1]="Replace.fx", [2]="ReplaceTex" }
Shader[2] = { [1]="Blur.fx", [2]="BlurTex" }

Class:__newConfig("Lib","Shader",Shader)