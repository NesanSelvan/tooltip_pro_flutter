# tooltip_plus

A powerful and flexible tooltip package for Flutter that goes beyond simple text. Create beautiful, highly customizable tooltips with rich content, shadows, blurs, and precise control over positioning and styling.

## Features

*   **Rich Content Support**: Create tooltips with titles, descriptions, icons, or any custom widget.
*   **Flexible Positioning**: Position tooltips TOP, BOTTOM, LEFT, or RIGHT of the target.
*   **Arrow Customization**: precise control over arrow direction, width, height, and offset.
*   **Styling**: Configure background colors, borders, shadows, and even background blur effects.
*   **Factory Constructors**: Built-in `minimal`, `rich`, and `error` factories for quick and beautiful presets.
*   **Auto-dismiss**: Optional auto-dismiss timer.
*   **Builders**: Dynamic content generation using builders.

## Getting started

Add `tooltip_plus` to your `pubspec.yaml`:

```yaml
dependencies:
  tooltip_plus_flutter: ^0.0.1
```

## Usage

Wrap any widget with `TooltipTarget` to add a tooltip to it.

### Basic Usage

```dart
TooltipTarget(
  tooltipContent: Text(
    "Hello World!",
    style: TextStyle(color: Colors.white),
  ),
  tooltipColor: Colors.black,
  child: Icon(Icons.info),
)
```

### Minimal Tooltip

Use the `.minimal` factory for simple text tooltips.

```dart
TooltipTarget.minimal(
  text: "Copied to clipboard!",
  child: IconButton(
    icon: Icon(Icons.copy),
    onPressed: () {},
  ),
)
```

### Rich Tooltip

Use the `.rich` factory for more complex notifications or information.

```dart
TooltipTarget.rich(
  title: "Feature Available",
  description: "You can now use the new improved search functionality.",
  icon: Icons.new_releases,
  child: Icon(Icons.info_outline),
)
```

### Arrow Customization

You can fully customize the arrow's size and position. This is useful when you want a specific look or need to align the arrow with a specific part of your UI.

```dart
TooltipTarget(
  arrowWidth: 20.0,   // Customize width
  arrowHeight: 15.0,  // Customize height
  customArrowOffset: 0.5, // Center the arrow (0.0 to 1.0)
  direction: TooltipDirection.top,
  child: MyWidget(),
  // ... other properties
)
```

### Error Tooltip

```dart
TooltipTarget.error(
  message: "Network connection lost.",
  child: Icon(Icons.wifi_off),
)
```

## Configuration

The `TooltipTarget` widget offers extensive configuration options.

### General
| Parameter | Type | Default | Description |
|---|---|---|---|
| `child` | `Widget` | **required** | The widget that will trigger the tooltip when tapped. |
| `tooltipContent` | `Widget?` | `null` | The content to display inside the tooltip. |
| `tooltipContentBuilder` | `Widget Function?` | `null` | A builder for the content, giving access to `context` and `hideTooltip` callback. |
| `tooltipBuilder` | `Widget Function?` | `null` | A builder for the entire tooltip target content. |
| `onPressed` | `VoidCallback?` | `null` | Callback triggered when the target is pressed. |
| `autoDismiss` | `Duration?` | `3s` | Time before the tooltip automatically closes. |

### Positioning & Dimensions
| Parameter | Type | Default | Description |
|---|---|---|---|
| `direction` | `TooltipDirection` | `top` | Position relative to the child (top, bottom, left, right). |
| `tooltipHeight` | `double` | `50.0` | Height of the tooltip container. |
| `tooltipWidth` | `double` | `50.0` | Width of the tooltip container. |
| `spacing` | `double` | `10.0` | Distance between the target child and the tooltip. |
| `horizontalPadding` | `double` | `0.0` | Horizontal padding adjustment. |
| `verticalPadding` | `double` | `0.0` | Vertical padding adjustment. |

### Arrow Customization
| Parameter | Type | Default | Description |
|---|---|---|---|
| `arrowDirection` | `TooltipArrowDirection` | `center` | Direction the arrow points relative to the tooltip edge. |
| `customArrowOffset` | `double` | `0.5` | Precise position of the arrow along the edge (0.0 to 1.0). |
| `arrowWidth` | `double` | `12.0` | Width of the arrow base in logical pixels. |
| `arrowHeight` | `double` | `10.0` | Height of the arrow in logical pixels. |

### Styling
| Parameter | Type | Default | Description |
|---|---|---|---|
| `tooltipColor` | `Color?` | `null` | Background color of the tooltip bubble. |
| `shadow` | `TooltipShadowConfig` | `const` | Configuration for drop shadows. |
| `blur` | `TooltipBlurConfig` | `const` | Configuration for background blur effects (glassmorphism). |
| `border` | `TooltipBorderConfig` | `const` | Configuration for tooltip borders. |


### Config Classes

**TooltipShadowConfig**
```dart
TooltipShadowConfig({
  bool enabled = false,
  Color? color,       // Shadow color
  double elevation,   // Elevation strength
  double blurRadius,  // Blur amount
})
```

**TooltipBlurConfig**
```dart
TooltipBlurConfig({
  bool enabled = false,
  double sigma,         // Blur strength (default: 5.0)
  Color? color,         // Tint color for the blur
  bool includeChild,    // Whether to blur the child widget too (default: false)
})
```

**TooltipBorderConfig**
```dart
TooltipBorderConfig({
  bool enabled = false,
  Color color,        // Border color
  double width,       // Border width
  double radius,      // Corner radius
})
```

## License

MIT
