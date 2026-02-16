import { isEnvBrowser } from "@/utils/misc";

export class Post<T = unknown> {
  private eventName: string;
  private data?: unknown;
  private mockData?: T;

  private constructor(eventName: string, data?: unknown, mockData?: T) {
    this.eventName = eventName;
    this.data = data;
    this.mockData = mockData;
  }

  public static async create<T>(
    eventName: string,
    data?: unknown,
    mockData?: T,
  ): Promise<T> {
    const instance = new Post(eventName, data, mockData);
    return instance.execute();
  }

  private async execute(): Promise<T> {
    const options = {
      method: "post",
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: JSON.stringify(this.data),
    };

    if (isEnvBrowser() && this.mockData) {
      return this.mockData;
    }

    const resourceName = (window as any).GetParentResourceName
      ? (window as any).GetParentResourceName()
      : "nui-frame-app";

    try {
      const resp = await fetch(
        `https://${resourceName}/${this.eventName}`,
        options,
      );
      
      if (!resp.ok) {
        throw new Error(`HTTP error! status: ${resp.status}`);
      }
      
      const text = await resp.text();
      if (!text) {
        throw new Error("Resposta vazia do servidor");
      }
      
      try {
        const respFormatted = JSON.parse(text);
        return respFormatted;
      } catch (jsonError) {
        throw new Error("Resposta inválida do servidor");
      }
    } catch (error) {
      throw error;
    }
  }
}
