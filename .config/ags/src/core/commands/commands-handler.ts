import CommandArgsConstructor from "./command-args-constructor";

type CommandHandlerFn<T = any> = (data: T) => any;
type CommandResponseFn = (data: any) => void;

export default class CommandsHandler {
  private commands = new Map<string, CommandHandlerFn>();
  private argConstructor = new CommandArgsConstructor();

  handleCommandSafe(request: string, response: CommandResponseFn): boolean {
    try {
      this.handleCommand(request, response);
      return true;
    } catch (error) {
      response(`Failed to handle command request "${request}": ${error}`)
      return false;
    }
  }

  handleCommand(request: string, response: CommandResponseFn) {
    const [command, args] = this.parseCommandRequest(request);
    const cArgs = this.argConstructor.tryParse(args)
    this.executeCommand(command, response, cArgs);
  }

  registerCommand<T>(commandName: string, handler: CommandHandlerFn<T>) {
    const command = this.commands.get(commandName);
    if (command) {
      throw new Error(`Handler for command "${command}" already exists`);
    }

    this.commands.set(commandName, handler);
  }

  private parseCommandRequest(request: string): [string, string[]] {
    const [command, ...args] = request.split(' ');
    return [command, args];
  }

  private executeCommand(command: string, response: CommandResponseFn, args: any) {
    const handler = this.commands.get(command);
    if (handler) {
      return response(handler(args));
    }

    throw new Error(`Handler for command "${command} not found"`);
  }
}
