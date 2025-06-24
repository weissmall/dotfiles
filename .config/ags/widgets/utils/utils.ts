export function ellipsis(text: string, maxLength: number) {
  if (text.length <= maxLength) return text
  return text.slice(0, maxLength) + "..."
}

export function ellipsisByLines(text: string, maxLength: number) {
  const splitted = text.split('\n')
  splitted.map((s) => ellipsis(s, maxLength))
  return splitted.join('\n')
}

export function stringOrNull(value: string | null, fallback: string): string {
  return value || fallback
}

export function toPercentStr(value: number): string {
  let valueStr: string;

  if (value >= 0 && value <= 1) {
    valueStr = (value.toFixed(2));
  } else {
    valueStr = (value / 100).toFixed(2);
  }

  return valueStr.slice(2);
}
