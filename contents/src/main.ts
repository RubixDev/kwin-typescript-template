print('Hello, World!')

for (let client of workspace.clientList()) {
    print(client.resourceClass, client.caption)
    if (client.resourceClass.toString() === 'plasmashell')
        console.info(`-> ${client.windowId}`)
}
