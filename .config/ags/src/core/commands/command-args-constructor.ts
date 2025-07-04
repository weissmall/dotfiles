export default class CommandArgsConstructor {
  tryParse<T>(args: any[]) {
    return this.pairParse<T>(args);
  }

  private pairParse<T = any>(args: any[]) {
    const obj = {} as any;
    for (let i = 0; i < args.length; i += 2) {
      obj[args[i]] = args[i + 1];
    }

    return obj as T;
  }
}
