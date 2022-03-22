Shader "Unlit/ImageBlend"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Pass
        {
            //Blend SrcAlpha OneMinusSrcAlpha
            //Blend SrcColor OneMinusDstColor

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma enable_d3d11_debug_symbols

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            fixed4 GetAlphaBlending(fixed4 SrcColor, fixed4 DstColor)
            {
                fixed4 Result = SrcColor;
                fixed SrcFactor = SrcColor.a;
                fixed DstFactor = 1.0f - SrcColor.a;
                Result.rgb = SrcFactor * SrcColor.rgb + DstFactor * DstColor.rgb;
                return Result;
            }

            fixed4 GetColorBlending(fixed4 SrcColor, fixed4 DstColor)
            {
                fixed4 Result = SrcColor;
                fixed3 SrcFactor = SrcColor.rgb;
                fixed3 DstFactor = 1.0f - DstColor.rgb;
                Result.rgb = SrcFactor * SrcColor.rgb + DstFactor * DstColor.rgb;
                //Result.r = SrcFactor.x * SrcColor.r + DstFactor.r * DstColor.r;
                //Result.g = SrcFactor.g * SrcColor.g + DstFactor.g * DstColor.g;
                //Result.b = SrcFactor.b * SrcColor.b + DstFactor.b * DstColor.b;
                return Result;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex, i.uv);

                fixed4 DstColor = fixed4(32.0f / 255.0f, 83.0f / 255.0f, 154.0f / 255.0f, 255.0f / 255.0f);
                //return GetAlphaBlending( col, DstColor );
                //return GetColorBlending( col, DstColor );
                return col;
            }
            ENDCG
        }

 /*       Pass
        {
            Blend One One
            BlendOp RevSub

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma enable_d3d11_debug_symbols

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert(appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex, i.uv);
                return col;
            }
            ENDCG
        }*/
    }
}