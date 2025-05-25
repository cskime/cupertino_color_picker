# Cupertino Color Picker

Flutter 플러그인 - iOS 네이티브 UIColorPickerViewController를 Flutter 앱에서 사용할 수 있게 해줍니다.

## 소개

이 플러그인은 iOS 14.0 이상에서 제공하는 UIColorPickerViewController를 Flutter 앱에서 사용할 수 있도록 해주는 iOS 전용 플러그인입니다.

**참고**: 이 플러그인은 iOS에서만 작동합니다. Android나 다른 플랫폼에서 사용하는 경우 PlatformException이 발생합니다.

## 사용 방법

### 설치

pubspec.yaml 파일에 의존성 추가:

```yaml
dependencies:
  cupertino_color_picker: ^0.0.1
```

### 기본 사용법

```dart
import 'package:cupertino_color_picker/cupertino_color_picker.dart';
import 'package:flutter/material.dart';

Future<void> showColorPickerExample() async {
  try {
    // 컬러 피커 표시 (Flutter의 다른 show* 함수들과 동일한 방식)
    final color = await showCupertinoColorPicker(
      initialColor: Colors.blue, // Color 객체 전달
      supportsAlpha: true, // 투명도(alpha) 지원 여부
    );
    
    // 사용자가 취소하면 null 반환
    if (color != null) {
      // Color 객체를 직접 사용
      print('선택된 색상: ${color.toString()}');
      
      // UI에 적용
      Container(color: color);
    }
  } catch (e) {
    print('컬러 피커 오류: $e');
  }
}
```

### 색상 공간 지원

이 플러그인은 iOS의 'Display P3' 색상 공간도 지원합니다. UIColorPickerViewController에서 'Display P3 Hex Color'로 색상을 선택한 경우에도 올바른 색상을 Flutter 앱에서 표현할 수 있도록 처리합니다.

플러그인은 Display P3 색상 공간에서 선택된 색상을 자동으로 sRGB 색상 공간으로 변환하여 Flutter에서 올바르게 표시될 수 있도록 합니다.

### 입력 파라미터

* `initialColor`: (선택사항) 초기 색상. Flutter의 `Color` 객체.
* `supportsAlpha`: 알파 채널(투명도) 지원 여부. 기본값은 `false`

### 반환 값

* 사용자가 색상을 선택하면 Flutter `Color` 객체 반환
* 사용자가 색상 선택을 취소하면 `null`

