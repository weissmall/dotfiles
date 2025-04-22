export default class Chain<T> {
    constructor(private value: T) { }

    then<V>(fn: (value: T) => V): Chain<V> {
        return new Chain(fn(this.value))
    }

    get() {
        return this.value
    }
}
