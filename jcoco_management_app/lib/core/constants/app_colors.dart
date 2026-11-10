import 'package:flutter/material.dart';

class AppColors {
  // Palette Exacte Figma / Stitch J.COCO
  static const Color primary = Color(0xFF031636);
  static const Color primaryContainer = Color(0xFF1A2B4C);
  static const Color primaryFixedDim = Color(0xFFB6C6F0);

  static const Color secondary = Color(0xFFA23E18);
  static const Color secondaryContainer = Color(0xFFFE8357);
  static const Color secondaryFixed = Color(0xFFFFDBCF);
  static const Color secondaryFixedDim = Color(0xFFFFB59C);
  static const Color onSecondary = Colors.white;

  static const Color surface = Color(0xFFFBF9F5);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFF5F3EF);
  static const Color surfaceContainer = Color(0xFFEFEEEA);
  static const Color surfaceContainerHigh = Color(0xFFEAE8E4);
  static const Color surfaceContainerHighest = Color(0xFFE4E2DE);

  static const Color onSurface = Color(0xFF1B1C1A);
  static const Color onSurfaceVariant = Color(0xFF44474E);
  static const Color outline = Color(0xFF75777F);

  static const Color error = Color(0xFFBA1A1A);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF93000A);

  static const Color tertiary = Color(0xFF231500);
  static const Color tertiaryFixed = Color(0xFFFFDEAD);
  static const Color tertiaryFixedDim = Color(0xFFFABC4D);

  static const Color emeraldSuccess = Color(0xFF059669);
  static const Color ocre = Color(0xFFE5A93C);
  static const Color ocreGold = Color(0xFFF3B84C);

  // Aliases sémantiques pour compatibilité
  static const Color terracotta = secondary;
  static const Color terracottaDark = Color(0xFFA8421C);
  static const Color terracottaLight = Color(0xFFF5EBE6);
  static const Color indigo900 = primary;
  static const Color indigo950 = Color(0xFF0C1527);
  static const Color indigo850 = Color(0xFF1A2B4C);
  static const Color sand = Color(0xFFD9BDAD);
  static const Color ebony = Color(0xFF231B17);
  static const Color darkBg = Color(0xFF17110C);
  static const Color hibiscusAlert = error;
}

class AppAssets {
  static const String logo =
      "https://lh3.googleusercontent.com/aida/AEtjO1W90U9Re7dEelzdA1RXDa2PiknmJpmrM9R_5y5G2CV3WgmTbmMt4TDN4SvwKE6KTgIwGk2-I3hxS5ev14kj3W_fSUaOoYSTHDMLA3IRL8edcLROxwy5ZR6CeRjh5FbbyzYtoePwkB9ytr0I2WxcTS9HO0kgOP3XCVvrdCD-drEzW_OyFiisSZ8XJ7Vb0ThZM8zqyEZ_wJIu4DXdMxu7Ng9vtj1x-GT8HnUaUqrImJPJ";
  static const String profile =
      "https://lh3.googleusercontent.com/aida-public/AB6AXuCbxCvbxCxRUuOVj4Frsbnd-2OyWFIkaE7sIiUzyGwr7jZ0p0EunU5eYSvHfPiUCjW-BVoba6l0uHXquCtpJgA2OOPnFmSz8tSOkdVXpChrGCPsbzpUVG55pK6xVK1yI6wIHTqlgM64jaEXTvflfBp_fulEBc8hbSLxNz_jA7s0a-bQj4SD2UZBHNH2FhoQbbEBPbwkUWUYv6RYg_2TWORYrumCy_cXCJhDNiQJsss";
  static const String tissuCoton =
      "https://lh3.googleusercontent.com/aida-public/AB6AXuD8Qs5Y4vGIydgj_HLTLTQKoD3BcyaUhaI597Er6UAdEws_1cCPR-yoSLm3mN2iUHZh73h4NsqCQK-kf1IJwItLP-eR70b7bUitxoyRyAChhLzShnGnvJCziW1ft8_chzgZe249LqmmiOsSq40EtxXcHphJkDufXoO4hRQSYKD46lyYO8QYBDbPKb5LEdGoXFecZV385-mDl-e9k1zdwLJpWvQG1z2JRe77E8EJJxQ";
  static const String cireAbeille =
      "https://lh3.googleusercontent.com/aida-public/AB6AXuCH9FDkTv2gy3IIUmPVkROqSz-pPzVfSSK7_DkRbyG_69hw0G7SIbolCjIzQKWfF_qUPMYPwSbibJmQcy6HSJQQwFHkkBqQRAE9BnlZJwstFdQBTbwJLVOLQ7jssH6WGqeE2znsNBuJ99jUXSW-tHBRpECmQ46QARmQ0FrskAw72wyB215EJ75WulI3EOSK68y88P1EJInqRaGlQ2_cw8yH9c2WhDUXXImk5Ca1iLU";
  static const String indigoNaturel =
      "https://lh3.googleusercontent.com/aida-public/AB6AXuA0gCDN05IdCNLcVl0AT1U9xAP9BDK0Mc-QGMF83t9eUcHd1g80QQUAmqjZJ5u4Kmpe8hW7ikAYjyLAtimb3qWc2U8TSHR-_t2rPJBXsJ1CA4OfP15rYV29JVy1ikDdVFFQTGpI39qN_qxjY2zf712U45i30zUt-qA-JNAT6NSFgmyG-fgT1W2sf7okoOPCKJnuI2uWuPEhjafTK5QrDfWaAd9Owlhr1DlutlrbuWE";
  static const String pagneBatik =
      "https://lh3.googleusercontent.com/aida-public/AB6AXuAJ2633JUdMwf6eDwufeyG0SyW8lIqNZ-lYbObniGoRdUmanE-GtfOaCpKJDRAZJgbLEigdMaF3065cyFTtyyB67vZ672NdimMNYTT_80xO2xn_UskHax6g2LwfcQSDjJ-HOQKRpliTC0nC7AcRqXmHVbWmyrG-vaBMiccX32v4fEcdoc57CyvH11ejTkydZ4Td5BIX-Su9QAmvynnfEMNxSaW_CltNz2kv2Vl1dDE";
}
