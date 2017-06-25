<GameFile>
  <PropertyGroup Name="TetrisClearStone" Type="Scene" ID="6018a8a5-2ed8-448d-b2e3-faa1e75b786f" Version="3.10.0.0" />
  <Content ctype="GameProjectContent">
    <Content>
      <Animation Duration="0" Speed="1.0000" />
      <ObjectData Name="Scene" Tag="24" ctype="GameNodeObjectData">
        <Size X="640.0000" Y="1136.0000" />
        <Children>
          <AbstractNodeData Name="panel" ActionTag="1918327196" Tag="34" IconVisible="False" TouchEnable="True" ClipAble="False" ColorAngle="90.0000" LeftEage="131" RightEage="131" TopEage="288" BottomEage="288" Scale9OriginX="-131" Scale9OriginY="-288" Scale9Width="262" Scale9Height="576" ctype="PanelObjectData">
            <Size X="640.0000" Y="1136.0000" />
            <Children>
              <AbstractNodeData Name="scene_bg" ActionTag="-389944647" Tag="64" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="-106.8960" RightMargin="-105.1040" TopMargin="-0.9088" BottomMargin="0.9088" LeftEage="281" RightEage="281" TopEage="374" BottomEage="374" Scale9OriginX="281" Scale9OriginY="374" Scale9Width="290" Scale9Height="388" ctype="ImageViewObjectData">
                <Size X="852.0000" Y="1136.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="319.1040" Y="568.9088" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.4986" Y="0.5008" />
                <PreSize X="1.3312" Y="1.0000" />
                <FileData Type="Normal" Path="ui/bg/singlematch_bg.png" Plist="" />
              </AbstractNodeData>
              <AbstractNodeData Name="tetris_panel" ActionTag="1060537929" Tag="32" IconVisible="False" LeftMargin="128.4999" RightMargin="130.5001" TopMargin="221.1080" BottomMargin="371.8920" TouchEnable="True" ClipAble="True" BackColorAlpha="102" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
                <Size X="381.0000" Y="543.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="318.9999" Y="643.3920" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.4984" Y="0.5664" />
                <PreSize X="0.5953" Y="0.4780" />
                <SingleColor A="255" R="150" G="200" B="255" />
                <FirstColor A="255" R="150" G="200" B="255" />
                <EndColor A="255" R="255" G="255" B="255" />
                <ColorVector ScaleY="1.0000" />
              </AbstractNodeData>
              <AbstractNodeData Name="army_left_bg" ActionTag="-137497383" Tag="59" IconVisible="False" LeftMargin="251.1734" RightMargin="338.8266" TopMargin="23.1700" BottomMargin="1082.8300" ctype="SpriteObjectData">
                <Size X="50.0000" Y="30.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="276.1734" Y="1097.8300" />
                <Scale ScaleX="0.7000" ScaleY="0.7000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.4315" Y="0.9664" />
                <PreSize X="0.0781" Y="0.0264" />
                <FileData Type="PlistSubImage" Path="army_left_bg.png" Plist="ui/plist/singlematch.plist" />
                <BlendFunc Src="1" Dst="771" />
              </AbstractNodeData>
              <AbstractNodeData Name="army_right_bg" ActionTag="-1507576402" Tag="58" IconVisible="False" LeftMargin="337.9887" RightMargin="252.0113" TopMargin="23.1700" BottomMargin="1082.8300" ctype="SpriteObjectData">
                <Size X="50.0000" Y="30.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="362.9887" Y="1097.8300" />
                <Scale ScaleX="0.7000" ScaleY="0.7000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5672" Y="0.9664" />
                <PreSize X="0.0781" Y="0.0264" />
                <FileData Type="PlistSubImage" Path="army_right_bg.png" Plist="ui/plist/singlematch.plist" />
                <BlendFunc Src="1" Dst="771" />
              </AbstractNodeData>
              <AbstractNodeData Name="lb_armynum" ActionTag="-1412607421" Tag="57" IconVisible="False" LeftMargin="295.0000" RightMargin="295.0000" TopMargin="23.1700" BottomMargin="1082.8300" CharWidth="25" CharHeight="30" LabelText="12" StartChar="0" ctype="TextAtlasObjectData">
                <Size X="50.0000" Y="30.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="320.0000" Y="1097.8300" />
                <Scale ScaleX="0.7000" ScaleY="0.7000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5000" Y="0.9664" />
                <PreSize X="0.0781" Y="0.0264" />
                <LabelAtlasFileImage_CNB Type="Normal" Path="ui/number_atlas/army_num_in.png" Plist="" />
              </AbstractNodeData>
              <AbstractNodeData Name="btn_down_low" ActionTag="618124103" Tag="15" IconVisible="False" LeftMargin="125.3403" RightMargin="418.6597" TopMargin="1019.4208" BottomMargin="20.5792" TouchEnable="True" FontSize="28" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="66" Scale9Height="74" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="96.0000" Y="96.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="173.3403" Y="68.5792" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.2708" Y="0.0604" />
                <PreSize X="0.1500" Y="0.0845" />
                <TextColor A="255" R="255" G="255" B="255" />
                <DisabledFileData Type="PlistSubImage" Path="down.png" Plist="ui/plist/common.plist" />
                <PressedFileData Type="PlistSubImage" Path="down.png" Plist="ui/plist/common.plist" />
                <NormalFileData Type="PlistSubImage" Path="down.png" Plist="ui/plist/common.plist" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="btn_down" ActionTag="1650258263" Tag="42" IconVisible="False" LeftMargin="125.6924" RightMargin="418.3076" TopMargin="873.9659" BottomMargin="166.0341" TouchEnable="True" FontSize="28" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="66" Scale9Height="74" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="96.0000" Y="96.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="173.6924" Y="214.0341" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.2714" Y="0.1884" />
                <PreSize X="0.1500" Y="0.0845" />
                <TextColor A="255" R="255" G="255" B="255" />
                <DisabledFileData Type="PlistSubImage" Path="down_fast.png" Plist="ui/plist/common.plist" />
                <PressedFileData Type="PlistSubImage" Path="down_fast.png" Plist="ui/plist/common.plist" />
                <NormalFileData Type="PlistSubImage" Path="down_fast.png" Plist="ui/plist/common.plist" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="btn_shift" ActionTag="-1740025647" Tag="27" IconVisible="False" LeftMargin="450.7410" RightMargin="36.2590" TopMargin="943.0548" BottomMargin="39.9452" TouchEnable="True" FontSize="28" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="123" Scale9Height="131" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="153.0000" Y="153.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="527.2410" Y="116.4452" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.8238" Y="0.1025" />
                <PreSize X="0.2391" Y="0.1347" />
                <TextColor A="255" R="255" G="255" B="255" />
                <DisabledFileData Type="PlistSubImage" Path="shift.png" Plist="ui/plist/common.plist" />
                <PressedFileData Type="PlistSubImage" Path="shift.png" Plist="ui/plist/common.plist" />
                <NormalFileData Type="PlistSubImage" Path="shift.png" Plist="ui/plist/common.plist" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="btn_right" ActionTag="-1978374155" Tag="26" IconVisible="False" LeftMargin="222.1837" RightMargin="321.8163" TopMargin="944.4210" BottomMargin="95.5790" TouchEnable="True" FontSize="28" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="66" Scale9Height="74" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="96.0000" Y="96.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="270.1837" Y="143.5790" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.4222" Y="0.1264" />
                <PreSize X="0.1500" Y="0.0845" />
                <TextColor A="255" R="255" G="255" B="255" />
                <DisabledFileData Type="PlistSubImage" Path="right.png" Plist="ui/plist/common.plist" />
                <PressedFileData Type="PlistSubImage" Path="right.png" Plist="ui/plist/common.plist" />
                <NormalFileData Type="PlistSubImage" Path="right.png" Plist="ui/plist/common.plist" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="btn_left" ActionTag="-780245045" Tag="25" IconVisible="False" LeftMargin="31.0177" RightMargin="512.9823" TopMargin="944.4210" BottomMargin="95.5790" TouchEnable="True" FontSize="28" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="66" Scale9Height="74" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="96.0000" Y="96.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="79.0177" Y="143.5790" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.1235" Y="0.1264" />
                <PreSize X="0.1500" Y="0.0845" />
                <TextColor A="255" R="255" G="255" B="255" />
                <DisabledFileData Type="PlistSubImage" Path="left.png" Plist="ui/plist/common.plist" />
                <PressedFileData Type="PlistSubImage" Path="left.png" Plist="ui/plist/common.plist" />
                <NormalFileData Type="PlistSubImage" Path="left.png" Plist="ui/plist/common.plist" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="fangkuai_3" ActionTag="2001307816" Tag="60" IconVisible="False" LeftMargin="268.8345" RightMargin="345.1655" TopMargin="75.0000" BottomMargin="1035.0000" ctype="SpriteObjectData">
                <Size X="26.0000" Y="26.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="281.8345" Y="1048.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.4404" Y="0.9225" />
                <PreSize X="0.0406" Y="0.0229" />
                <FileData Type="PlistSubImage" Path="fangkuai.png" Plist="ui/plist/common.plist" />
                <BlendFunc Src="1" Dst="771" />
              </AbstractNodeData>
              <AbstractNodeData Name="lb_left_line" ActionTag="2089445126" Tag="25" IconVisible="False" LeftMargin="292.0001" RightMargin="287.9999" TopMargin="63.0000" BottomMargin="1023.0000" CharWidth="30" CharHeight="50" LabelText="10" StartChar="0" ctype="TextAtlasObjectData">
                <Size X="60.0000" Y="50.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="322.0001" Y="1048.0000" />
                <Scale ScaleX="0.6000" ScaleY="0.6000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5031" Y="0.9225" />
                <PreSize X="0.0938" Y="0.0440" />
                <LabelAtlasFileImage_CNB Type="Normal" Path="ui/number_atlas/number.png" Plist="" />
              </AbstractNodeData>
              <AbstractNodeData Name="btn_pause" ActionTag="1734774958" Tag="104" IconVisible="False" LeftMargin="389.5000" RightMargin="175.5000" TopMargin="869.5000" BottomMargin="191.5000" TouchEnable="True" FontSize="14" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="45" Scale9Height="53" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="75.0000" Y="75.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="427.0000" Y="229.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.6672" Y="0.2016" />
                <PreSize X="0.1172" Y="0.0660" />
                <TextColor A="255" R="65" G="65" B="70" />
                <DisabledFileData Type="PlistSubImage" Path="game_pause.png" Plist="ui/plist/common.plist" />
                <PressedFileData Type="PlistSubImage" Path="game_pause.png" Plist="ui/plist/common.plist" />
                <NormalFileData Type="PlistSubImage" Path="game_pause.png" Plist="ui/plist/common.plist" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
            </Children>
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position X="320.0000" Y="568.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.5000" Y="0.5000" />
            <PreSize X="1.0000" Y="1.0000" />
            <SingleColor A="255" R="255" G="255" B="255" />
            <FirstColor A="255" R="150" G="200" B="255" />
            <EndColor A="255" R="255" G="255" B="255" />
            <ColorVector ScaleY="1.0000" />
          </AbstractNodeData>
          <AbstractNodeData Name="lb_left_bg" ActionTag="-1229280255" Tag="42" IconVisible="False" RightMargin="400.0000" TopMargin="-1.0000" BottomMargin="977.0000" ctype="SpriteObjectData">
            <Size X="240.0000" Y="160.0000" />
            <Children>
              <AbstractNodeData Name="next_bg" ActionTag="-1369861544" Tag="71" IconVisible="False" LeftMargin="87.4052" RightMargin="62.5948" TopMargin="13.1595" BottomMargin="56.8405" TouchEnable="True" ClipAble="False" BackColorAlpha="102" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
                <Size X="90.0000" Y="90.0000" />
                <AnchorPoint />
                <Position X="87.4052" Y="56.8405" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.3642" Y="0.3553" />
                <PreSize X="0.3750" Y="0.5625" />
                <SingleColor A="255" R="150" G="200" B="255" />
                <FirstColor A="255" R="150" G="200" B="255" />
                <EndColor A="255" R="255" G="255" B="255" />
                <ColorVector ScaleY="1.0000" />
              </AbstractNodeData>
              <AbstractNodeData Name="next_bg_title" ActionTag="1665194029" Tag="66" IconVisible="False" LeftMargin="11.8657" RightMargin="148.1343" TopMargin="20.5559" BottomMargin="109.4441" LeftEage="26" RightEage="26" TopEage="9" BottomEage="9" Scale9OriginX="26" Scale9OriginY="9" Scale9Width="28" Scale9Height="12" ctype="ImageViewObjectData">
                <Size X="80.0000" Y="30.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="51.8657" Y="124.4441" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.2161" Y="0.7778" />
                <PreSize X="0.3333" Y="0.1875" />
                <FileData Type="PlistSubImage" Path="next.png" Plist="ui/plist/common.plist" />
              </AbstractNodeData>
            </Children>
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position X="120.0000" Y="1057.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.1875" Y="0.9305" />
            <PreSize X="0.3750" Y="0.1408" />
            <FileData Type="PlistSubImage" Path="lb_left_bg.png" Plist="ui/plist/singlematch.plist" />
            <BlendFunc Src="1" Dst="771" />
          </AbstractNodeData>
          <AbstractNodeData Name="lb_right_bg" ActionTag="1067362998" Tag="58" IconVisible="False" LeftMargin="400.5939" RightMargin="-0.5939" TopMargin="-1.0000" BottomMargin="977.0000" ctype="SpriteObjectData">
            <Size X="240.0000" Y="160.0000" />
            <Children>
              <AbstractNodeData Name="target_bottom" ActionTag="935267850" Tag="59" IconVisible="False" LeftMargin="60.3550" RightMargin="17.6450" TopMargin="7.7928" BottomMargin="33.2072" ctype="SpriteObjectData">
                <Size X="162.0000" Y="119.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="141.3550" Y="92.7072" />
                <Scale ScaleX="0.8000" ScaleY="0.8000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5890" Y="0.5794" />
                <PreSize X="0.6750" Y="0.7437" />
                <FileData Type="PlistSubImage" Path="target_bottom.png" Plist="ui/plist/singlematch.plist" />
                <BlendFunc Src="1" Dst="771" />
              </AbstractNodeData>
              <AbstractNodeData Name="fangkuai_bg" ActionTag="-577313846" Tag="60" IconVisible="False" LeftMargin="102.9901" RightMargin="62.0099" TopMargin="24.2910" BottomMargin="60.7090" ctype="SpriteObjectData">
                <Size X="75.0000" Y="75.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="140.4901" Y="98.2090" />
                <Scale ScaleX="0.8000" ScaleY="0.8000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5854" Y="0.6138" />
                <PreSize X="0.3125" Y="0.4688" />
                <FileData Type="PlistSubImage" Path="water_bg.png" Plist="ui/plist/common.plist" />
                <BlendFunc Src="1" Dst="771" />
              </AbstractNodeData>
              <AbstractNodeData Name="lb_result" ActionTag="-1537425997" Tag="61" IconVisible="False" LeftMargin="90.9847" RightMargin="44.0153" TopMargin="81.8615" BottomMargin="53.1385" CharWidth="15" CharHeight="25" LabelText="100/100" StartChar="/" ctype="TextAtlasObjectData">
                <Size X="105.0000" Y="25.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="143.4847" Y="65.6385" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5979" Y="0.4102" />
                <PreSize X="0.4375" Y="0.1563" />
                <LabelAtlasFileImage_CNB Type="Normal" Path="ui/number_atlas/number_small.png" Plist="" />
              </AbstractNodeData>
            </Children>
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position X="520.5939" Y="1057.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.8134" Y="0.9305" />
            <PreSize X="0.3750" Y="0.1408" />
            <FileData Type="PlistSubImage" Path="lb_right_bg.png" Plist="ui/plist/singlematch.plist" />
            <BlendFunc Src="1" Dst="771" />
          </AbstractNodeData>
        </Children>
      </ObjectData>
    </Content>
  </Content>
</GameFile>