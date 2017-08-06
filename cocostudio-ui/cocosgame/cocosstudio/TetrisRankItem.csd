<GameFile>
  <PropertyGroup Name="TetrisRankItem" Type="Scene" ID="96a8b2c8-3dcc-4407-bb99-def2fecddf03" Version="3.10.0.0" />
  <Content ctype="GameProjectContent">
    <Content>
      <Animation Duration="0" Speed="1.0000" />
      <ObjectData Name="Scene" Tag="24" ctype="GameNodeObjectData">
        <Size X="640.0000" Y="1136.0000" />
        <Children>
          <AbstractNodeData Name="panel" ActionTag="1918327196" Tag="34" IconVisible="False" RightMargin="-20.0000" TopMargin="513.0000" BottomMargin="513.0000" TouchEnable="True" ClipAble="False" ColorAngle="90.0000" LeftEage="131" RightEage="131" TopEage="288" BottomEage="288" Scale9OriginX="-131" Scale9OriginY="-288" Scale9Width="262" Scale9Height="576" ctype="PanelObjectData">
            <Size X="660.0000" Y="110.0000" />
            <Children>
              <AbstractNodeData Name="bg" ActionTag="1639409085" Tag="95" IconVisible="False" LeftMargin="-5.0000" RightMargin="5.0000" ctype="SpriteObjectData">
                <Size X="660.0000" Y="110.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="325.0000" Y="55.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.4924" Y="0.5000" />
                <PreSize X="1.0000" Y="1.0000" />
                <FileData Type="Normal" Path="ui/rank/rank_line_bg.png" Plist="" />
                <BlendFunc Src="1" Dst="771" />
              </AbstractNodeData>
              <AbstractNodeData Name="lb_point" ActionTag="-1335678199" Tag="186" IconVisible="False" LeftMargin="498.3600" RightMargin="105.6400" TopMargin="41.0000" BottomMargin="41.0000" FontSize="28" LabelText="1234" ShadowOffsetX="1.0000" ShadowOffsetY="-1.0000" ShadowEnabled="True" ctype="TextObjectData">
                <Size X="56.0000" Y="28.0000" />
                <AnchorPoint ScaleY="0.5000" />
                <Position X="498.3600" Y="55.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="253" G="244" B="2" />
                <PrePosition X="0.7551" Y="0.5000" />
                <PreSize X="0.0848" Y="0.2545" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="64" G="57" B="53" />
              </AbstractNodeData>
              <AbstractNodeData Name="sp_point" ActionTag="1879714344" Tag="98" IconVisible="False" LeftMargin="452.0678" RightMargin="163.9322" TopMargin="37.0000" BottomMargin="37.0000" ctype="SpriteObjectData">
                <Size X="44.0000" Y="36.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="474.0678" Y="55.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.7183" Y="0.5000" />
                <PreSize X="0.0667" Y="0.3273" />
                <FileData Type="PlistSubImage" Path="score_bg.png" Plist="ui/plist/common.plist" />
                <BlendFunc Src="1" Dst="771" />
              </AbstractNodeData>
              <AbstractNodeData Name="lb_name" ActionTag="-2040902252" Tag="97" IconVisible="False" LeftMargin="123.3890" RightMargin="312.6110" TopMargin="38.5000" BottomMargin="38.5000" FontSize="32" LabelText="玩家名字七个字" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ShadowEnabled="True" ctype="TextObjectData">
                <Size X="224.0000" Y="33.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="235.3890" Y="55.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.3567" Y="0.5000" />
                <PreSize X="0.3394" Y="0.3000" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="64" G="57" B="53" />
              </AbstractNodeData>
              <AbstractNodeData Name="sp_cup" ActionTag="-613042344" Tag="96" IconVisible="False" LeftMargin="16.0000" RightMargin="568.0000" TopMargin="19.0000" BottomMargin="19.0000" ctype="SpriteObjectData">
                <Size X="76.0000" Y="72.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="54.0000" Y="55.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.0818" Y="0.5000" />
                <PreSize X="0.1152" Y="0.6545" />
                <FileData Type="Normal" Path="ui/rank/icon_gold_cup.png" Plist="" />
                <BlendFunc Src="1" Dst="771" />
              </AbstractNodeData>
              <AbstractNodeData Name="lb_rank" ActionTag="1076750147" VisibleForFrame="False" Tag="104" IconVisible="False" LeftMargin="9.0000" RightMargin="561.0000" TopMargin="35.0000" BottomMargin="35.0000" CharWidth="30" CharHeight="40" LabelText="100" StartChar="0" ctype="TextAtlasObjectData">
                <Size X="90.0000" Y="40.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="54.0000" Y="55.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.0818" Y="0.5000" />
                <PreSize X="0.1364" Y="0.3636" />
                <LabelAtlasFileImage_CNB Type="Normal" Path="ui/number_atlas/rank.png" Plist="" />
              </AbstractNodeData>
            </Children>
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position X="330.0000" Y="568.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.5156" Y="0.5000" />
            <PreSize X="1.0313" Y="0.0968" />
            <SingleColor A="255" R="255" G="255" B="255" />
            <FirstColor A="255" R="150" G="200" B="255" />
            <EndColor A="255" R="255" G="255" B="255" />
            <ColorVector ScaleY="1.0000" />
          </AbstractNodeData>
        </Children>
      </ObjectData>
    </Content>
  </Content>
</GameFile>