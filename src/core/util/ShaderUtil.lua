--
-- User: wangys
-- ShaderUtil shader工具类

local ShaderUtil = {}

-- fileUtils
local fileUtils = cc.FileUtils:getInstance()

-- 默认source
local vertDefaultSource = "\n"..
                           "attribute vec4 a_position; \n" ..
                           "attribute vec2 a_texCoord; \n" ..
                           "attribute vec4 a_color; \n"..                                                    
                           "#ifdef GL_ES  \n"..
                           "varying lowp vec4 v_fragmentColor;\n"..
                           "varying mediump vec2 v_texCoord;\n"..
                           "#else                      \n" ..
                           "varying vec4 v_fragmentColor; \n" ..
                           "varying vec2 v_texCoord;  \n"..
                           "#endif    \n"..
                           "void main() \n"..
                           "{\n" ..
                            "gl_Position = CC_PMatrix * a_position; \n"..
                           "v_fragmentColor = a_color;\n"..
                           "v_texCoord = a_texCoord;\n"..
                           "}"
local State = 
{
  NORMAL = 0,
  GRAY = 1,
}

--------------------------------
-- 设置灰色
-- @function [parent=#ShaderUtil] setGray
function ShaderUtil.setGray(node)
    -- 9切图
    if node.getVirtualRenderer and iskindof(node:getVirtualRenderer(), "ccui.Scale9Sprite") then
        node:getVirtualRenderer():setState(State.GRAY)
        return
    end

    -- 文字
    if node.getVirtualRenderer and iskindof(node:getVirtualRenderer(), "cc.Label") then
        node:getVirtualRenderer():enableGray(true)
        return
    end

    -- 添加shader
    if not ShaderUtil.addGrayShader then
        ShaderUtil.addGrayShader = fileUtils:getStringFromFile("shader/add_gray.fsh")
    end

    local glProgram = cc.GLProgram:createWithByteArrays(vertDefaultSource, ShaderUtil.addGrayShader)
    glProgram:bindAttribLocation(cc.ATTRIBUTE_NAME_POSITION, cc.VERTEX_ATTRIB_POSITION) 
    glProgram:bindAttribLocation(cc.ATTRIBUTE_NAME_COLOR, cc.VERTEX_ATTRIB_COLOR)
    glProgram:bindAttribLocation(cc.ATTRIBUTE_NAME_TEX_COORD, cc.VERTEX_ATTRIB_TEX_COORD)
    glProgram:link()
    glProgram:updateUniforms()

    if node.getVirtualRenderer then
        local virtualRenderer = node:getVirtualRenderer()
        if virtualRenderer.getSprite then
            virtualRenderer:getSprite():setGLProgram(glProgram)
        end
    else
        node:setGLProgram(glProgram)
    end
end

--------------------------------
-- 移除灰色
-- @function [parent=#ShaderUtil] removeGray
function ShaderUtil.removeGray(node)
    -- 9切图
    if node.getVirtualRenderer and iskindof(node:getVirtualRenderer(), "ccui.Scale9Sprite") then
        node:getVirtualRenderer():setState(State.NORMAL)
        return
    end

    -- 文字
    if node.getVirtualRenderer and iskindof(node:getVirtualRenderer(), "cc.Label") then
        node:getVirtualRenderer():enableGray(false)
        return
    end

    -- 恢复色彩
    if not ShaderUtil.removeGrayShader then
        ShaderUtil.removeGrayShader = fileUtils:getStringFromFile("shader/remove_gray.fsh")
    end

    local glProgram = cc.GLProgram:createWithByteArrays(vertDefaultSource, ShaderUtil.removeGrayShader)
    glProgram:bindAttribLocation(cc.ATTRIBUTE_NAME_POSITION,cc.VERTEX_ATTRIB_POSITION)
    glProgram:bindAttribLocation(cc.ATTRIBUTE_NAME_COLOR,cc.VERTEX_ATTRIB_COLOR)
    glProgram:bindAttribLocation(cc.ATTRIBUTE_NAME_TEX_COORD,cc.VERTEX_ATTRIB_FLAG_TEX_COORDS)
    glProgram:link()
    glProgram:updateUniforms()

    if node.getVirtualRenderer then
        local virtualRenderer = node:getVirtualRenderer()
        if virtualRenderer.getSprite then
            virtualRenderer:getSprite():setGLProgram(glProgram)
        end
        return
    else
        node:setGLProgram(glProgram)
    end
end

return ShaderUtil
